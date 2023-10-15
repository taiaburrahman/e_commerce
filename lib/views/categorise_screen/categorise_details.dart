import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/consts/loding_indicator.dart';
import 'package:groundfresh/views/categorise_screen/item_details.dart';
import 'package:groundfresh/views/controllers/firestore_services.dart';
import 'package:groundfresh/views/controllers/product_Controller.dart';

class CategoriseDetails extends StatelessWidget {
  final String? title;
  const CategoriseDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Scaffold(
      appBar: AppBar(
        title: title!.text
            .fontFamily(bold)
            .color(darkFontGrey)
            .overflow(TextOverflow.ellipsis)
            .make(),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirestoreServices.getProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: lodingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "No product found".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 260),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]["p_imgs"][0],
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                5.heightBox,
                                "${data[index]["p_name"]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .overflow(TextOverflow.ellipsis)
                                    .make(),
                                5.heightBox,
                                Row(
                                  children: [
                                    "${data[index]["p_unit"]}"
                                        .text
                                        .color(darkFontGrey)
                                        .make(),
                                    5.widthBox,
                                    "${data[index]["p_unittext"]}"
                                        .text
                                        .color(darkFontGrey)
                                        .make(),
                                  ],
                                ),
                                5.heightBox,
                                "${data[index]["p_price"]}"
                                    .numCurrency
                                    .text
                                    .color(greencolor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make(),
                              ],
                            )
                                .box
                                .white
                                .outerShadowSm
                                .margin(const EdgeInsets.only(right: 5))
                                .rounded
                                .padding(const EdgeInsets.all(10))
                                .make()
                                .onTap(() {
                              // controller.checkIfFev(data[index]);
                              Get.to(() => ItemDetails(
                                    data: data[index],
                                  ));
                            });
                          }),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
