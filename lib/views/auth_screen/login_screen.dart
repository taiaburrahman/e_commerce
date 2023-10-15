import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:groundfresh/adimn/admin_home.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/seller/seller_home.dart';
import 'package:groundfresh/views/auth_screen/signup_screen.dart';
import 'package:groundfresh/views/controllers/auth_controller.dart';
import 'package:groundfresh/views/home_screen/dashboard_screen.dart';
import 'package:groundfresh/widget_common/appLogo_widget.dart';
import 'package:groundfresh/widget_common/customTextField.dart';
import 'package:groundfresh/widget_common/ourButton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: Container(
        height: context.screenHeight,
        width: context.screenWidth,
        color: greencolor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                  height: context.screenHeight / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      appLogoWidget(),
                      10.heightBox,
                      loginto.text.fontFamily(semibold).white.make()
                    ],
                  )),
              Container(
                height: 700,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child: Obx(
                  () => Column(
                    children: [
                      customTextFeild(
                          hint: emailhint,
                          title: email,
                          isPass: false,
                          controller: emailcontroller),
                      5.heightBox,
                      customTextFeild(
                          hint: passwordhint,
                          title: password,
                          isPass: true,
                          controller: passwordcontroller),
                      5.heightBox,
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: forgetpass.text.color(greencolor).make(),
                        ),
                      ),
                      5.heightBox,
                      controller.isLoding.value
                          ? const CircularProgressIndicator(
                              color: greencolor,
                            )
                          : ourButton(
                              color: greencolor,
                              textColor: whiteColor,
                              title: login,
                              onPress: () {
                                var email = emailcontroller.text.trim();
                                var pass = passwordcontroller.text.trim();
                                signIn(email, pass);
                              }).box.width(context.screenHeight - 50).make(),
                      5.heightBox,
                      createAnAccount.text.color(fontGrey).make(),
                      5.heightBox,
                      ourButton(
                          color: scaffoldColor,
                          textColor: greencolor,
                          title: signup,
                          onPress: () {
                            Get.to(() => const SignUpScreen());
                          }).box.width(context.screenHeight - 50).make(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "Buyer") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardScreen(),
            ),
          );
        } else if (documentSnapshot.get('rool') == "Seller") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SellerHome(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminHome(),
            ),
          );
        }
      } else {
        VxToast.show(context, msg: 'Document does not exist on the database');
      }
    });
  }

  void signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      route();
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: "wrong password");
    }
  }
}
