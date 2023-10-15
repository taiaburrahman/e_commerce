import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';

import 'package:groundfresh/model/category_model.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var totalprice = 0.obs;
  var subcat = [];
  var isFev = false.obs;

  getSubCategory(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_list.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalprice.value = price * quantity.value;
  }

  addToCart(title, img, sellername, qty, tprice, context) async {
    await firestore.collection(cartCollection).doc().set({
      "title": title,
      "imgs": img,
      "seller": sellername,
      "quantity": qty,
      "tprice": tprice,
      "added_by": currentUser!.uid,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    totalprice.value = 0;
    quantity.value = 0;
  }

  // addWishList(docId, context) async {
  //   await firestore.collection(productsCollection).doc(docId).set({
  //     "p_wishlist": FieldValue.arrayUnion([currentUser!.uid])
  //   });
  //   isFev(true);
  //   VxToast.show(context, msg: "Added to Favorite");
  // }

  // removeWishList(docId, context) async {
  //   await firestore.collection(productsCollection).doc(docId).set({
  //     "p_wishlist": FieldValue.arrayRemove([currentUser!.uid]),
  //   });
  //   isFev(false);
  //   VxToast.show(context, msg: "Removed From Fevorite");
  // }

  // checkIfFev(data) async {
  //   if (data["p_wishlist"].contains(currentUser!.uid)) {
  //     isFev(true);
  //   } else {
  //     isFev(false);
  //   }
  // }
}
