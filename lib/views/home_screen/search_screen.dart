import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/consts/loding_indicator.dart';
import 'package:groundfresh/views/categorise_screen/item_details.dart';
import 'package:groundfresh/views/controllers/firestore_services.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
          future: FirestoreServices.searchproduct(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: lodingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No product found".text.makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filtereed = data
                  .where((element) => element["p_name"]
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()))
                  .toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 260,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  children: filtereed
                      .mapIndexed((currentValue, index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Image.network(
                                  filtereed[index]['p_imgs'][0],
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                5.heightBox,
                                "${filtereed[index]["p_name"]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .overflow(TextOverflow.ellipsis)
                                    .make(),
                                5.heightBox,
                                Row(
                                  children: [
                                    "${filtereed[index]["p_unit"]}"
                                        .text
                                        .color(darkFontGrey)
                                        .make(),
                                    5.widthBox,
                                    "${filtereed[index]["p_unittext"]}"
                                        .text
                                        .color(darkFontGrey)
                                        .make(),
                                  ],
                                ),
                                5.heightBox,
                                "${filtereed[index]["p_price"]}"
                                    .numCurrency
                                    .text
                                    .color(greencolor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make(),
                              ])
                              .box
                              .white
                              .margin(const EdgeInsets.only(right: 5))
                              .rounded
                              .padding(const EdgeInsets.all(8))
                              .make()
                              .onTap(() {
                            Get.to(() => ItemDetails(data: filtereed[index]));
                          }))
                      .toList(),
                ),
              );
            }
          }),
    );
  }
}
