import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/consts/lists.dart';
import 'package:groundfresh/consts/loding_indicator.dart';
import 'package:groundfresh/views/controllers/firestore_services.dart';
import 'package:groundfresh/views/controllers/profile_controller.dart';
import 'package:groundfresh/views/order_screen/order_screen.dart';
import 'package:groundfresh/views/profile_screen/component/details_cart.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return Scaffold(
      body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: lodingIndicator(),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return Container(
                height: context.screenHeight,
                width: context.screenWidth,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            data["img"] == ""
                                ? const Icon(
                                    Icons.person_3_sharp,
                                    size: 50,
                                    color: darkFontGrey,
                                  ).box.roundedFull.clip(Clip.antiAlias).make()
                                : Image.network(
                                    data["img"],
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                            5.widthBox,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data["name"]}"
                                    .text
                                    .size(16)
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                5.heightBox,
                                "${data["email"]}".text.white.make(),
                                5.heightBox,
                                "${data["location"]}".text.white.make(),
                              ],
                            )),
                            10.widthBox,
                          ],
                        ),
                        const Spacer(),
                        FutureBuilder(
                            future: FirestoreServices.getcount(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: lodingIndicator(),
                                );
                              } else {
                                var countData = snapshot.data;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    detailsCart(
                                        context.screenWidth / 2.2,
                                        countData[0].toString(),
                                        "in your cart"),
                                    detailsCart(
                                        context.screenWidth / 2.2,
                                        countData[1].toString(),
                                        "in your order"),
                                  ],
                                );
                              }
                            }),
                      ],
                    )
                        .box
                        .color(greencolor)
                        .height(250)
                        .padding(const EdgeInsets.only(bottom: 20, top: 25))
                        .make(),
                    ListTile(
                            onTap: () {
                              Get.to(() => const OrderScreenB());
                            },
                            leading: Image.asset(
                              profileButtonIcon[0],
                              width: 22,
                            ),
                            title: profileButtonList[0]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make())
                        .box
                        .rounded
                        .white
                        .padding(const EdgeInsets.symmetric(
                          horizontal: 16,
                        ))
                        .margin(const EdgeInsets.symmetric(horizontal: 10))
                        .shadowSm
                        .make()
                        .box
                        .padding(const EdgeInsets.symmetric(vertical: 10))
                        .color(greencolor)
                        .make(),
                    10.heightBox,
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.center,
                      height: 50,
                      child: TextFormField(
                        controller: controller.locationcontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: whiteColor,
                          hintText: "Add location",
                          suffixIcon:
                              Icon(Icons.arrow_circle_right_rounded).onTap(() {
                            controller.setlocation();
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
