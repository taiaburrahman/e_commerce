import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/consts/loding_indicator.dart';
import 'package:groundfresh/views/cart_screen/shipping_screen.dart';
import 'package:groundfresh/views/controllers/cart_controller.dart';
import 'package:groundfresh/views/controllers/firestore_services.dart';
import 'package:groundfresh/widget_common/ourButton.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: lodingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart is emty".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);

              controller.productSnapshot = data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Image.network(
                                "${data[index]["imgs"]}",
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                              title:
                                  "${data[index]["title"]}   (x${data[index]["quantity"]})"
                                      .text
                                      .fontFamily(semibold)
                                      .size(16)
                                      .make(),
                              subtitle: "${data[index]["tprice"]}"
                                  .numCurrency
                                  .text
                                  .color(greencolor)
                                  .fontFamily(semibold)
                                  .make(),
                              trailing: const Icon(
                                Icons.delete,
                                color: redColor,
                              ).onTap(() {
                                FirestoreServices.cartDelete(data[index].id);
                              }),
                            );
                          }),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(() => "${controller.totalP.value}"
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(greencolor)
                            .make())
                      ],
                    )
                        .box
                        .roundedSM
                        .color(grey)
                        .width(context.screenWidth - 50)
                        .padding(const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10))
                        .make(),
                    SizedBox(
                      width: context.screenWidth - 50,
                      child: ourButton(
                          color: greencolor,
                          onPress: () {
                            Get.to(() => ShippingScreen());
                          },
                          textColor: whiteColor,
                          title: "Proceed to shipping"),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
