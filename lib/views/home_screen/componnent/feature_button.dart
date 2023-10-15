import 'package:groundfresh/consts/consts.dart';

Widget featureButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 50,
        fit: BoxFit.fill,
      ),
      5.widthBox,
      title!.text
          .fontFamily(semibold)
          .color(darkFontGrey)
          .overflow(TextOverflow.ellipsis)
          .make()
    ],
  )
      .box
      .white
      .width(200)
      .roundedSM
      .outerShadowSm
      .padding(const EdgeInsets.all(4))
      .margin(const EdgeInsets.only(right: 4))
      .make();
}
