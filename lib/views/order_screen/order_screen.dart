import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/consts/loding_indicator.dart';
import 'package:groundfresh/views/controllers/firestore_services.dart';
import 'package:groundfresh/views/order_screen/order_details.dart';

class OrderScreenB extends StatelessWidget {
  const OrderScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "My order".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getAllOrder(),
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

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: "${index + 1}"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(bold)
                        .make(),
                    title: data[index]["order_code"]
                        .toString()
                        .text
                        .color(darkFontGrey)
                        .make(),
                    subtitle: data[index]['total_amound']
                        .toString()
                        .numCurrency
                        .text
                        .make(),
                    trailing: IconButton(
                        onPressed: () {
                          Get.to(() => OrderDetails(
                                data: data[index],
                              ));
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: darkFontGrey,
                        )),
                  );
                },
              );
            }
          }),
    );
  }
}
