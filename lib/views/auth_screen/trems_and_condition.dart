import 'package:groundfresh/consts/consts.dart';

class TermAndCondition extends StatelessWidget {
  const TermAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Terms and Condition".text.color(darkFontGrey).make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            "•	Users must agree to the terms and conditions to access and use the app."
                .text
                .color(darkFontGrey)
                .make(),
            5.heightBox,
            "•	Users are responsible for maintaining the confidentiality of their account information."
                .text
                .color(darkFontGrey)
                .make(),
            5.heightBox,
            "•	Users must comply with all applicable laws and regulations."
                .text
                .color(darkFontGrey)
                .make(),
            5.heightBox,
            "•	Farmers are responsible for the accuracy and legality of their listings."
                .text
                .color(darkFontGrey)
                .make(),
            5.heightBox,
            "•	Users should review and verify information before making a purchase."
                .text
                .color(darkFontGrey)
                .make(),
            5.heightBox,
            "•	The app facilitates transactions but is not responsible for disputes between users and farmers."
                .text
                .color(darkFontGrey)
                .make(),
            5.heightBox,
            "•	User data is collected and processed in accordance with the app's privacy policy."
                .text
                .color(darkFontGrey)
                .make(),
            5.heightBox,
            "•	The app is not liable for any damages or interruptions in app availability."
                .text
                .color(darkFontGrey)
                .make(),
            5.heightBox,
            "•	The app may modify the terms and conditions with notice to users."
                .text
                .color(darkFontGrey)
                .make()
          ],
        ),
      ),
    );
  }
}
