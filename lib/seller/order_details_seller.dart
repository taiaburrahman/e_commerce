import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/seller/controller/ordercontrollerss.dart';
import 'package:groundfresh/views/order_screen/order_components/order_place_details.dart';
import 'package:groundfresh/widget_common/ourButton.dart';

class OrderDetailsSeller extends StatefulWidget {
  final dynamic data;
  const OrderDetailsSeller({super.key, this.data});

  @override
  State<OrderDetailsSeller> createState() => _OrderDetailsSellerState();
}

class _OrderDetailsSellerState extends State<OrderDetailsSeller> {
  var controller = Get.find<OrderControllerss>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.confirmed.value = widget.data["order_confirmed"];
    controller.ondelivery.value = widget.data["order_on_delivery"];
    controller.delivered.value = widget.data["order_delivered"];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 50,
            width: context.screenWidth,
            child: ourButton(
                color: Colors.purple,
                onPress: () {
                  controller.confirmed(true);
                  controller.changeStatus(
                      title: "order_confirmed",
                      status: true,
                      docID: widget.data.id);
                },
                textColor: whiteColor,
                title: "Confirmed"),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    children: [
                      SwitchListTile(
                        activeColor: Colors.purple,
                        value: true,
                        onChanged: (value) {},
                        title: "Placed".text.color(darkFontGrey).make(),
                      ),
                      SwitchListTile(
                        activeColor: Colors.purple,
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                        },
                        title: "Confirmed".text.color(darkFontGrey).make(),
                      ),
                      SwitchListTile(
                        activeColor: Colors.purple,
                        value: controller.ondelivery.value,
                        onChanged: (value) {
                          controller.ondelivery.value = value;
                          controller.changeStatus(
                              title: "order_on_delivery",
                              status: value,
                              docID: widget.data.id);
                        },
                        title: "on Delivery".text.color(darkFontGrey).make(),
                      ),
                      SwitchListTile(
                        activeColor: Colors.purple,
                        value: controller.delivered.value,
                        onChanged: (value) {
                          controller.delivered.value = value;

                          controller.changeStatus(
                              title: "order_delivered",
                              status: value,
                              docID: widget.data.id);
                        },
                        title: "Delivered".text.color(darkFontGrey).make(),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                orderPlaceDetails(
                    d1: "${widget.data["order_code"]}",
                    d2: "${widget.data["shipping_method"]}",
                    title1: "Order Code",
                    title2: "Shipping Method"),
                5.heightBox,
                orderPlaceDetails(
                    d1: widget.data["order_date"].toDate(),
                    d2: widget.data["payment_method"],
                    title1: "Order Date",
                    title2: "Payment Method"),
                5.heightBox,
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Shipping Address".text.fontFamily(semibold).make(),
                          "Address: ${widget.data["order_by_address"]}"
                              .text
                              .make(),
                          "City: ${widget.data["order_by_city"]}".text.make(),
                          "State: ${widget.data["order_by_state"]}".text.make(),
                          "Postal Code: ${widget.data["order_by_postalcode"]}"
                              .text
                              .make(),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            "Total Price".text.fontFamily(semibold).make(),
                            10.heightBox,
                            "${widget.data["total_amound"]}"
                                .numCurrency
                                .text
                                .make(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                "Ordered Product".text.color(darkFontGrey).size(16).make(),
                10.heightBox,
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(1, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Name: ${widget.data["orders"][index]["title"]}"
                              .text
                              .make(),
                          "Quantity: ${widget.data["orders"][index]["quantity"]}"
                              .text
                              .make(),
                        ],
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
