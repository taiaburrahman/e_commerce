import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/model/category_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class PController extends GetxController {
  var pnamecontroller = TextEditingController();
  var pdescontoller = TextEditingController();
  var ppricecontroller = TextEditingController();
  var pquantitycontroller = TextEditingController();
  var unitcontroller = TextEditingController();
  var categoryList = <String>[].obs;
  var isLoding = false.obs;
  var subCategoryList = <String>[].obs;
  var unitvalue = "";
  var options = [
    'Fruits',
    "Vegetables",
    "Leaf Vegetables",
    "Coriander leaves",
    "Pumpkin leaves",
    "Carrot",
    "Brinjal",
    "Tomato",
    "Potato",
  ];

  var currentItemSelected = "Fruits";

  var categorylistt = "Fruits";

  List<Category> categoryy = [];
  var pImgList = RxList<dynamic>.generate(3, (index) => null);
  var pikImgLink = [];

  var categoryvalue = "".obs;
  var subcategoryvalue = "".obs;

  pikImg(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImgList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadPImgae() async {
    pikImgLink.clear();
    for (var item in pImgList) {
      if (item != null) {
        var filename = basename(item.path);
        var desination = "images/seller${currentUser!.uid}/$filename";
        Reference ref = FirebaseStorage.instance.ref().child(desination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pikImgLink.add(n);
      }
    }
  }

  uploadproduct(context) async {
    var store = firestore.collection(productsCollection).doc();
    await store.set({
      "isFeatured": false,
      "p_category": categorylistt,
      "p_des": pdescontoller.text,
      "p_imgs": FieldValue.arrayUnion(pikImgLink),
      "p_name": pnamecontroller.text,
      "p_price": ppricecontroller.text,
      "p_quantity": pquantitycontroller.text,
      "p_unittext": unitvalue,
      "p_unit": unitcontroller.text,
      "p_rating": "4.0",
      "vendor_id": currentUser!.uid,
      "p_seller": "Antora",
      "p_wishlist": FieldValue.arrayUnion([]),
      "featured_id": "",
    });

    isLoding(false);
    VxToast.show(context, msg: "Prduct uploded");
  }

  deleteProduct(docId) async {
    await firestore.collection(productsCollection).doc(docId).delete();
  }
}
