import 'package:flutter/services.dart';

import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/widget_common/ourButton.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confrim".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(
          height: 1,
          color: greencolor,
          endIndent: 10,
          indent: 10,
        ),
        10.heightBox,
        "Are you sure want to exit".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                onPress: () {
                  SystemNavigator.pop();
                },
                color: greencolor,
                textColor: whiteColor,
                title: "Yes"),
            ourButton(
                onPress: () {
                  Navigator.pop(context);
                },
                color: greencolor,
                textColor: whiteColor,
                title: "No"),
          ],
        )
      ],
    ).box.color(whiteColor).padding(const EdgeInsets.all(15)).make(),
  );
}
