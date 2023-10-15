import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImgpath = "".obs;
  var isLoding = false.obs;
  var profileimgLink = "";
  var namecontroller = TextEditingController();
  var locationcontroller = TextEditingController();

  changeimg(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgpath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uplodProfileimg() async {
    var filename = basename(profileImgpath.value);
    var destination = "images/${currentUser!.uid}/filename";

    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgpath.value));
    profileimgLink = await ref.getDownloadURL();
  }

  updateProfile(name, img) async {
    var store = firestore.collection(userCollections).doc(currentUser!.uid);
    await store.set(
      {
        "name": name,
        "img": img,
      },
    );
    isLoding(false);
  }

  setlocation() async {
    var store = firestore.collection(userCollections).doc(currentUser!.uid);
    await store.set({
      "location": locationcontroller.text,
    }, SetOptions(merge: true));
  }
}
