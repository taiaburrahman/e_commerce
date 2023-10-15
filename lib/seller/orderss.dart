import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/consts/loding_indicator.dart';
import 'package:groundfresh/seller/controller/ordercontrollerss.dart';
import 'package:groundfresh/seller/order_details_seller.dart';
import 'package:groundfresh/seller/store_services.dart';

class OrdersS extends StatelessWidget {
  const OrdersS({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrderControllerss());
    return Scaffold(
      appBar: AppBar(
        title: "Orders".text.color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
          stream: StoreServices.getOrderss(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: lodingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No order yet!".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      height: context.screenHeight,
                      width: context.screenWidth,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: "${index + 1}"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(bold)
                                .make(),
                            title: "${data[index]['order_code']}"
                                .text
                                .color(darkFontGrey)
                                .make(),
                            subtitle: '${data[index]["total_amound"]}'
                                .numCurrency
                                .text
                                .make(),
                            trailing: IconButton(
                                onPressed: () {
                                  Get.to(() => OrderDetailsSeller(
                                        data: data[index],
                                      ));
                                },
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: darkFontGrey,
                                )),
                          );
                        },
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
