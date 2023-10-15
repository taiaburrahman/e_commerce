import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';

class CartController extends GetxController {
  var addressControltter = TextEditingController();
  var cityControllter = TextEditingController();
  var stateControllter = TextEditingController();
  var postalControllter = TextEditingController();
  var phonecontorller = TextEditingController();
  var searchcontroller = TextEditingController();

  late dynamic productSnapshot;
  var products = [];
  var placeingOrder = false.obs;
  var totalP = 0.obs;

  calculate(data) {
    totalP.value = 80;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]["tprice"].toString());
    }
  }

  var paymentIndex = 0.obs;

  changePymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmound}) async {
    placeingOrder(true);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      "order_by": currentUser!.uid,
      "order_by_email": currentUser!.email,
      "order_by_address": addressControltter.text,
      "order_by_state": stateControllter.text,
      "order_by_city": cityControllter.text,
      "order_by_phone": phonecontorller.text,
      "order_by_postalcode": postalControllter.text,
      "shipping_method": "Home Delivery",
      "payment_method": orderPaymentMethod,
      "order_code": "927373629",
      "order_placed": true,
      "order_confirmed": false,
      "order_delivered": false,
      "order_on_delivery": false,
      "total_amound": totalAmound,
      "orders": FieldValue.arrayUnion(products),
      "vendors": FieldValue.arrayUnion([
        "Z8cXLaxxPvPOXm6vY3YLAceMUnG3"
      ]),
      "order_date": FieldValue.serverTimestamp(),
    });
    placeingOrder(false);
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        "imgs": productSnapshot[i]["imgs"],
        "quantity": productSnapshot[i]["quantity"],
        "title": productSnapshot[i]["title"],
        "tprice": productSnapshot[i]["tprice"],
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
