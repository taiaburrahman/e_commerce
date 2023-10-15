import 'package:groundfresh/consts/consts.dart';

Widget detailsCart(widht, String? count, String? title) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make()
    ],
  )
      .box
      .white
      .rounded
      .width(widht)
      .height(80)
      .padding(const EdgeInsets.all(4))
      .make();
}
