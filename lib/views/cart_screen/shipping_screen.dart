import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/views/cart_screen/payment_screen.dart';
import 'package:groundfresh/views/controllers/cart_controller.dart';
import 'package:groundfresh/widget_common/customTextField.dart';
import 'package:groundfresh/widget_common/ourButton.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ourButton(
            onPress: () {
              if (controller.addressControltter.text.length > 2 ||
                  controller.cityControllter.text.length > 2 ||
                  controller.phonecontorller.text.length > 10) {
                Get.to(() => const PaymentScren());
              } else {
                VxToast.show(context, msg: "please fill the form");
              }
            },
            color: greencolor,
            textColor: whiteColor,
            title: "Continue"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            customTextFeild(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressControltter),
            customTextFeild(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityControllter),
            customTextFeild(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateControllter),
            customTextFeild(
                hint: "Postal code",
                isPass: false,
                title: "Postal code",
                controller: controller.postalControllter,
                keyboardType: TextInputType.number),
            customTextFeild(
                hint: "Phone",
                isPass: false,
                title: "phone",
                controller: controller.phonecontorller,
                keyboardType: TextInputType.phone),
          ],
        ),
      ),
    );
  }
}
