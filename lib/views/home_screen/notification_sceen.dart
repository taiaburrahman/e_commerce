import 'package:groundfresh/consts/consts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Notification".text.color(darkFontGrey).make(),
      ),
      body: Center(
        child: "Not found data"
            .text
            .color(darkFontGrey)
            .size(16)
            .fontFamily(semibold)
            .make(),
      ),
    );
  }
}
