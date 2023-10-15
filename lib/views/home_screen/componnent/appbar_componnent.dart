import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/views/home_screen/notification_sceen.dart';

appbar(
  context,
) {
  return AppBar(
    elevation: 0,
    backgroundColor: scaffoldColor,
    title: Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: const Image(
        image: AssetImage(icAppLogo),
        height: 60,
        width: 70,
      ),
    ),
    actions: [
      InkWell(
        onTap: () {
          Get.to(() => const NotificationScreen());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Container(
            width: 30,
            child: Icon(
              Icons.notifications,
              color: whiteColor,
            ),
            decoration: BoxDecoration(
                color: grey, borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
    ],
  );
}
