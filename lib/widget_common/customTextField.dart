import 'package:groundfresh/consts/consts.dart';

Widget customTextFeild(
    {String? title,
    String? hint,
    controller,
    isPass,
    validator,
    keyboardType}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      "${title}".text.color(greencolor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        validator: validator,
        keyboardType: keyboardType,
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
            hintStyle: const TextStyle(
              fontFamily: semibold,
            ),
            hintText: hint,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: greencolor))),
      )
    ],
  );
}
