import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/consts/lists.dart';
import 'package:groundfresh/consts/loding_indicator.dart';
import 'package:groundfresh/views/controllers/cart_controller.dart';
import 'package:groundfresh/views/home_screen/dashboard_screen.dart';
import 'package:groundfresh/widget_common/ourButton.dart';

class PaymentScren extends StatelessWidget {
  const PaymentScren({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMehodImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Stack(alignment: Alignment.topRight, children: [
                      Image.asset(
                        paymentMehodImg[index],
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.fill,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                  activeColor: greencolor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  value: true,
                                  onChanged: (value) {}),
                            )
                          : Container(),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: paymentlist[index]
                              .text
                              .white
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .size(16)
                              .make())
                    ]),
                  ),
                );
              }),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: controller.placeingOrder.value
              ? Center(
                  child: lodingIndicator(),
                )
              : ourButton(
                  onPress: () async {
                    await controller.placeMyOrder(
                      orderPaymentMethod:
                          paymentlist[controller.paymentIndex.value],
                      totalAmound: controller.totalP.value,
                    );
                    await controller.clearCart();
                    Get.offAll(() => const DashboardScreen());
                  },
                  color: greencolor,
                  textColor: whiteColor,
                  title: "Place my order"),
        ),
      ),
    );
  }
}
