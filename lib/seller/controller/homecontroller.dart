import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';

class Homecontrollerr extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getusername();
  }

  var navIndex = 0.obs;

  var username = "";

  // getusername() async {
  //   dynamic n = await firestore
  //       .collection(userCollections)
  //       .where("userId", isEqualTo: currentUser!.uid)
  //       .get()
  //       .then((value) => {
  //             if (value.docs.isNotEmpty) {value.docs.single["name"]}
  //           });
  //   username = n;
  //   print(username);
  // }
}
