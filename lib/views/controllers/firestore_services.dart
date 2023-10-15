import 'package:groundfresh/consts/consts.dart';

class FirestoreServices {
  static getUser(uid) {
    return firestore
        .collection(userCollections)
        .where('userId', isEqualTo: uid)
        .snapshots();
  }

  //get proudct
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where("p_category", isEqualTo: category)
        .snapshots();
  }

  //get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where("added_by", isEqualTo: uid)
        .snapshots();
  }

  //cart delete
  static cartDelete(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  // all order get

  static getAllOrder() {
    return firestore
        .collection(ordersCollection)
        .where("order_by", isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getcount() async {
    var res = Future.wait([
      firestore
          .collection(cartCollection)
          .where("added_by", isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where("order_by", isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      })
    ]);
    return res;
  }

  static allProductGet() {
    return firestore.collection(productsCollection).snapshots();
  }

  static getfeatureproduct() {
    return firestore
        .collection(productsCollection)
        .where("isFeatured", isEqualTo: true)
        .get();
  }

  static searchproduct(title) {
    return firestore.collection(productsCollection).get();
  }
}
