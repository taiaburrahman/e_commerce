import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/consts/loding_indicator.dart';
import 'package:groundfresh/seller/addproduct.dart';
import 'package:groundfresh/seller/controller/pontroller.dart';
import 'package:groundfresh/seller/store_services.dart';

class ProductScreenn extends StatelessWidget {
  const ProductScreenn({super.key});

  @override
  Widget build(BuildContext context) {
    var contorller = Get.put(PController());
    return Scaffold(
      appBar: AppBar(
        title: "All products".text.color(darkFontGrey).make(),
        elevation: 0,
        backgroundColor: scaffoldColor,
      ),
      body: StreamBuilder(
          stream: StoreServices.getsellrProduct(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: lodingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No product found".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    children: List.generate(
                  data.length,
                  (index) => ListTile(
                    leading: Image.network(
                      data[index]["p_imgs"][0],
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    title: "${data[index]["p_name"]}".text.make(),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            "${data[index]["p_category"]}".text.make(),
                            10.widthBox,
                            " ${data[index]["p_quantity"]}"
                                .text
                                .color(greencolor)
                                .make()
                          ],
                        ),
                        "${data[index]["p_price"]}".numCurrency.text.make(),
                      ],
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          contorller.deleteProduct(data[index].id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: redColor,
                        )),
                  ),
                )).box.padding(const EdgeInsets.all(10)).make(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: const Icon(Icons.add),
          onPressed: () async {
            Get.to(() => ProductAdd());
          }),
    );
  }
}
