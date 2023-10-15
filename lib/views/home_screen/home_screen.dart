import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/consts/lists.dart';
import 'package:groundfresh/consts/loding_indicator.dart';
import 'package:groundfresh/views/categorise_screen/item_details.dart';
import 'package:groundfresh/views/controllers/cart_controller.dart';
import 'package:groundfresh/views/controllers/firestore_services.dart';
import 'package:groundfresh/views/home_screen/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerr = Get.put(CartController());
    return Container(
      height: context.screenHeight,
      width: context.screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //search
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              height: 50,
              child: TextFormField(
                controller: controllerr.searchcontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: whiteColor,
                  hintText: search,
                  suffixIcon: Icon(Icons.search).onTap(() {
                    Get.to(() => SearchScreen(
                          title: controllerr.searchcontroller.text,
                        ));
                  }),
                ),
              ),
            ),
            //slider
            10.heightBox,
            VxSwiper.builder(
                aspectRatio: 16 / 5,
                autoPlay: true,
                height: 140,
                enlargeCenterPage: true,
                itemCount: slider.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    slider[index],
                    fit: BoxFit.fill,
                  )
                      .box
                      .rounded
                      .clip(Clip.antiAlias)
                      .margin(const EdgeInsets.symmetric(horizontal: 5))
                      .make();
                }),
            10.heightBox,

            10.heightBox,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: greencolor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  featureproduct.text
                      .color(whiteColor)
                      .size(18)
                      .fontFamily(semibold)
                      .make(),
                  10.heightBox,
                  //feature product
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: FutureBuilder(
                          future: FirestoreServices.getfeatureproduct(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: lodingIndicator(),
                              );
                            } else if (snapshot.data!.docs.isEmpty) {
                              return "No feature product"
                                  .text
                                  .white
                                  .makeCentered();
                            } else {
                              var feauterproductData = snapshot.data!.docs;
                              return Row(
                                children: List.generate(
                                    feauterproductData.length,
                                    (index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              feauterproductData[index]
                                                  ["p_imgs"][0],
                                              width: 130,
                                              height: 130,
                                              fit: BoxFit.cover,
                                            ),
                                            5.heightBox,
                                            "${feauterproductData[index]["p_name"]}"
                                                .text
                                                .fontFamily(semibold)
                                                .color(darkFontGrey)
                                                .overflow(TextOverflow.ellipsis)
                                                .make(),
                                            5.heightBox,
                                            Row(
                                              children: [
                                                "${feauterproductData[index]["p_unit"]}"
                                                    .text
                                                    .color(darkFontGrey)
                                                    .make(),
                                                5.widthBox,
                                                "${feauterproductData[index]["p_unittext"]}"
                                                    .text
                                                    .color(darkFontGrey)
                                                    .make(),
                                              ],
                                            ),
                                            5.heightBox,
                                            "${feauterproductData[index]["p_price"]}"
                                                .numCurrency
                                                .text
                                                .color(greencolor)
                                                .fontFamily(bold)
                                                .size(16)
                                                .make()
                                          ],
                                        )
                                            .box
                                            .white
                                            .margin(
                                                const EdgeInsets.only(right: 5))
                                            .rounded
                                            .padding(const EdgeInsets.all(8))
                                            .make()
                                            .onTap(() {
                                          Get.to(() => ItemDetails(
                                              data: feauterproductData[index]));
                                        })),
                              );
                            }
                          })),
                ],
              ),
            ),
            10.heightBox,
            allproduct.text
                .color(darkFontGrey)
                .size(18)
                .fontFamily(semibold)
                .make(),
            10.heightBox,
            //all product

            StreamBuilder(
                stream: FirestoreServices.allProductGet(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: lodingIndicator(),
                    );
                  } else {
                    var allproductData = snapshot.data!.docs;
                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allproductData.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                mainAxisExtent: 260),
                        itemBuilder: (context, index) {
                          return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Image.network(
                                  allproductData[index]['p_imgs'][0],
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                5.heightBox,
                                "${allproductData[index]["p_name"]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .overflow(TextOverflow.ellipsis)
                                    .make(),
                                5.heightBox,
                                Row(
                                  children: [
                                    "${allproductData[index]["p_unit"]}"
                                        .text
                                        .color(darkFontGrey)
                                        .make(),
                                    5.widthBox,
                                    "${allproductData[index]["p_unittext"]}"
                                        .text
                                        .color(darkFontGrey)
                                        .make(),
                                  ],
                                ),
                                5.heightBox,
                                "${allproductData[index]["p_price"]}"
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
                            Get.to(
                                () => ItemDetails(data: allproductData[index]));
                          });
                        });
                  }
                })
          ],
        ),
      ),
    );
  }
}
