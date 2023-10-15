import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/consts/lists.dart';
import 'package:groundfresh/views/categorise_screen/categorise_details.dart';
import 'package:groundfresh/views/controllers/product_Controller.dart';

class CategoriseScreen extends StatelessWidget {
  const CategoriseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Container(
      height: context.screenHeight,
      width: context.screenWidth,
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            allcategorise.text
                .fontFamily(semibold)
                .color(darkFontGrey)
                .size(18)
                .make(),
            10.heightBox,
            const Divider(
              indent: 10,
              endIndent: 10,
              height: 1,
              color: greencolor,
              thickness: 2,
            ),
            10.heightBox,
            GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 170,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.asset(
                        categoriseImg[index],
                        fit: BoxFit.cover,
                        height: 100,
                        width: 150,
                      ),
                      10.heightBox,
                      categoriesList[index]
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .maxLines(2)
                          .overflow(TextOverflow.ellipsis)
                          .make()
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .clip(Clip.antiAlias)
                      .outerShadowSm
                      .padding(const EdgeInsets.all(5))
                      .make()
                      .onTap(() {
                    controller.getSubCategory(categoriesList[index]);
                    Get.to(
                        () => CategoriseDetails(title: categoriesList[index]),
                        transition: Transition.zoom);
                  });
                })
          ],
        ),
      ),
    );
  }
}
