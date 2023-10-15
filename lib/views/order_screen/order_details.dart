import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/views/order_screen/order_components/order_place_details.dart';
import 'order_components/order_status.dart';

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Order Details"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: Column(
        children: [
          orderStutas(
              color: greencolor,
              icon: Icons.done,
              title: "Placed",
              showDone: data["order_placed"]),
          orderStutas(
              color: greencolor,
              icon: Icons.thumb_up,
              title: "Confirmed",
              showDone: data["order_confirmed"]),
          orderStutas(
              color: greencolor,
              icon: Icons.car_crash,
              title: "on Delivery",
              showDone: data["order_on_delivery"]),
          orderStutas(
              color: greencolor,
              icon: Icons.done_all_rounded,
              title: "Delivered",
              showDone: data["order_delivered"]),
          const Divider(),
          orderPlaceDetails(
              d1: data["order_code"],
              d2: data["shipping_method"],
              title1: "Order Code",
              title2: "Shipping Method"),
          5.heightBox,
          orderPlaceDetails(
              d1: data["order_date"].toDate(),
              d2: data["payment_method"],
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
                    "Address: ${data["order_by_address"]}".text.make(),
                    "City: ${data["order_by_city"]}".text.make(),
                    "State: ${data["order_by_state"]}".text.make(),
                    "Postal Code: ${data["order_by_postalcode"]}".text.make(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      "Total Price".text.fontFamily(semibold).make(),
                      10.heightBox,
                      "${data["total_amound"]}".numCurrency.text.make(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
