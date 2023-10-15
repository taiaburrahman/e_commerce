import 'package:groundfresh/consts/consts.dart';

Widget orderPlaceDetails({title1, title2, d1, d2}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "$title1".text.fontFamily(semibold).make(),
          "$d1".text.color(greencolor).fontFamily(semibold).make()
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "$title2".text.fontFamily(semibold).make(),
          "$d2".text.color(greencolor).fontFamily(semibold).make()
        ],
      )
    ],
  ).box.padding(const EdgeInsets.all(10)).make();
}
