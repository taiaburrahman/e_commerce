import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/views/auth_screen/login_screen.dart';
import 'package:groundfresh/views/auth_screen/trems_and_condition.dart';
import 'package:groundfresh/views/controllers/auth_controller.dart';
import 'package:groundfresh/widget_common/appLogo_widget.dart';
import 'package:groundfresh/widget_common/customTextField.dart';
import 'package:groundfresh/widget_common/ourButton.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck = false;
  // var controller = Get.put(AuthController());
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var retyppasswordcontroller = TextEditingController();

  var options = [
    'Buyer',
    'Seller',
  ];
  var _currentItemSelected = "Buyer";
  var rool = "Buyer";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.screenHeight,
        width: context.screenWidth,
        color: greencolor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: context.screenHeight / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      appLogoWidget(),
                      5.heightBox,
                      "Sign Up to $appname"
                          .text
                          .fontFamily(semibold)
                          .white
                          .make()
                    ],
                  )),
              Container(
                height: 700,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton<String>(
                      dropdownColor: whiteColor,
                      isExpanded: true,
                      iconEnabledColor: Colors.white,
                      focusColor: greencolor,
                      items: options.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(
                            dropDownStringItem,
                            style: const TextStyle(
                              color: greencolor,
                              fontFamily: semibold,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValueSelected) {
                        setState(() {
                          _currentItemSelected = newValueSelected!;
                          rool = newValueSelected;
                        });
                      },
                      value: _currentItemSelected,
                    ).box.rounded.make(),
                    10.heightBox,
                    customTextFeild(
                        hint: namehint,
                        title: name,
                        controller: namecontroller,
                        isPass: false),
                    5.heightBox,
                    customTextFeild(
                        keyboardType: TextInputType.emailAddress,
                        hint: emailhint,
                        title: email,
                        controller: emailcontroller,
                        isPass: false),
                    5.heightBox,
                    customTextFeild(
                        hint: passwordhint,
                        title: password,
                        controller: passwordcontroller,
                        isPass: true),
                    5.heightBox,
                    customTextFeild(
                        validator: (value) {
                          if (retyppasswordcontroller.text !=
                              passwordcontroller.text) {
                            return "Password did not match";
                          } else {
                            return null;
                          }
                        },
                        hint: retypepass,
                        title: retypepass,
                        controller: retyppasswordcontroller,
                        isPass: true),
                    10.heightBox,
                    Row(
                      children: [
                        Checkbox(
                            activeColor: greencolor,
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            }),
                        5.widthBox,
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.to(() => TermAndCondition());
                            },
                            child: RichText(
                                text: const TextSpan(children: [
                              TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                      fontFamily: regular, color: fontGrey)),
                              TextSpan(
                                  text: termAndCondition,
                                  style: TextStyle(
                                      fontFamily: regular, color: greencolor)),
                              TextSpan(
                                  text: "&",
                                  style: TextStyle(
                                      fontFamily: regular, color: fontGrey)),
                              TextSpan(
                                  text: privacyPolicy,
                                  style: TextStyle(
                                      fontFamily: regular, color: greencolor))
                            ])),
                          ),
                        )
                      ],
                    ),
                    10.heightBox,
                    ourButton(
                        color: isCheck == true ? greencolor : scaffoldColor,
                        textColor: whiteColor,
                        title: signup,
                        onPress: () async {
                          var email = emailcontroller.text.trim();
                          var name = namecontroller.text.trim();
                          var pass = passwordcontroller.text.trim();

                          if (isCheck != false) {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: pass)
                                .then((value) => {
                                      storageData(
                                          name, pass, email, rool, context)
                                    })
                                .then((value) {
                              VxToast.show(context, msg: "Successfully signup");
                              Get.to(() => const LoginScreen());
                            });
                          }
                        }).box.width(context.screenHeight - 50).make(),
                    15.heightBox,
                    Row(
                      children: [
                        alreadyhaveanAccount.text.color(fontGrey).make(),
                        TextButton(
                            onPressed: () {
                              Get.to(() => const LoginScreen());
                            },
                            child: login.text.color(greencolor).make())
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
