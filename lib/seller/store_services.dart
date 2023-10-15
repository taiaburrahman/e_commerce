import 'package:groundfresh/consts/consts.dart';

class StoreServices {
  static getsellrProduct(uid) {
    return firestore
        .collection(productsCollection)
        .where("vendor_id", isEqualTo: uid)
        .snapshots();
  }

  static getOrderss(uid) {
    return firestore
        .collection(ordersCollection)
        .where("vendors", arrayContains: uid)
        .snapshots();
  }
}
