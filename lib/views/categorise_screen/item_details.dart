import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/views/controllers/product_Controller.dart';

class ItemDetails extends StatelessWidget {
  final dynamic data;
  const ItemDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        autoPlay: false,
                        height: 350,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemCount: data["p_imgs"].length,
                        itemBuilder: (contex, index) {
                          return Image.network(
                            data["p_imgs"][index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                              .box
                              .margin(const EdgeInsets.symmetric(horizontal: 5))
                              .make();
                        }),
                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${data["p_name"]}"
                              .text
                              .size(16)
                              .fontFamily(bold)
                              .color(darkFontGrey)
                              .maxLines(1)
                              .overflow(TextOverflow.ellipsis)
                              .make(),
                          5.heightBox,
                          VxRating(
                            isSelectable: false,
                            value: double.parse(data["p_rating"]),
                            onRatingUpdate: (value) {},
                            normalColor: textfieldGrey,
                            selectionColor: golden,
                            size: 20,
                            maxRating: 5,
                            count: 5,
                          ),
                          10.heightBox,
                          "${data["p_price"]}"
                              .numCurrency
                              .text
                              .color(greencolor)
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  "Seller"
                                      .text
                                      .color(fontGrey)
                                      .fontFamily(semibold)
                                      .make(),
                                  5.heightBox,
                                  "${data["p_seller"]}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .size(16)
                                      .make()
                                ],
                              )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  "Location"
                                      .text
                                      .color(fontGrey)
                                      .fontFamily(semibold)
                                      .make(),
                                  5.heightBox,
                                  "Dhaka".text.make()
                                ],
                              ),
                            ],
                          )
                              .box
                              .height(70)
                              .color(whiteColor)
                              .padding(
                                  const EdgeInsets.symmetric(horizontal: 10))
                              .make(),
                          Column(
                            children: [
                              Obx(
                                () => Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    "Quantity:"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.widthBox,
                                    IconButton(
                                        onPressed: () {
                                          controller.decreaseQuantity();
                                          controller.calculateTotalPrice(
                                              int.parse(data["p_price"]));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    controller.quantity.value.text
                                        .size(16)
                                        .fontFamily(bold)
                                        .color(darkFontGrey)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increaseQuantity(
                                              int.parse(data["p_quantity"]));
                                          controller.calculateTotalPrice(
                                              int.parse(data["p_price"]));
                                        },
                                        icon: const Icon(Icons.add)),
                                    10.widthBox,
                                    "${data["p_quantity"]}:Available"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.widthBox,
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  "Delivery Charge: 80.00".text.make()
                                ],
                              ),
                              5.heightBox,
                              Obx(
                                () => Row(
                                  children: [
                                    "Total Price (include delivery charge):"
                                        .text
                                        .color(darkFontGrey)
                                        .make(),
                                    10.widthBox,
                                    "${controller.totalprice.value + 80}"
                                        .numCurrency
                                        .text
                                        .color(greencolor)
                                        .size(16)
                                        .fontFamily(bold)
                                        .make(),
                                  ],
                                ),
                              )
                            ],
                          )
                              .box
                              .color(whiteColor)
                              .padding(const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5))
                              .shadowSm
                              .make(),
                          10.heightBox,
                          "Description"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          10.heightBox,
                          "${data["p_des"]}".text.color(darkFontGrey).make(),
                          10.heightBox,
                        ],
                      ),
                    )
                  ],
                ),
              )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: greencolor),
                      onPressed: () {
                        if (controller.quantity.value >= 1) {
                          controller.addToCart(
                              data["p_name"],
                              data["p_imgs"][0],
                              data["p_seller"],
                              controller.quantity.value,
                              controller.totalprice.value,
                              context);
                          VxToast.show(context, msg: "Added to cart");
                        } else {
                          VxToast.show(context, msg: 'Quantity is 0');
                        }
                      },
                      child: addtocart.text
                          .fontFamily(semibold)
                          .color(whiteColor)
                          .make()),
                ),
              )
            ],
          )),
    );
  }
}
