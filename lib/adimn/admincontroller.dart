import 'package:get/get.dart';
import 'package:groundfresh/consts/firebase_const.dart';

class Adminconroller extends GetxController {
  var navIndex = 0.obs;
}

class StoreServicess {
  static getAllseller() {
    return firestore
        .collection(userCollections)
        .where("rool", isEqualTo: 'Seller')
        .snapshots();
  }

  static getAllBuyer() {
    return firestore
        .collection(userCollections)
        .where("rool", isEqualTo: 'Buyer')
        .snapshots();
  }
}
