import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/views/home_screen/dashboard_screen.dart';

class AuthController extends GetxController {
  var isLoding = false.obs;

  //login

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signup

  Future<UserCredential?> signup({email, password, context}) async {
    UserCredential? userCredential;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signout
  signout(context) async {
    await auth
        .signOut()
        .then((value) => Get.offAll(() => const DashboardScreen()));
  }
}

//User data store
storageData(
    String name, String password, String email, String rool, context) async {
  User? userid = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
      "name": name,
      "pass": password,
      'rool': rool,
      'email': email,
      "createAt": DateTime.now(),
      "userId": userid.uid,
      "location": "Dhaka",
      "img": "",
      "cart_count": "00",
      "order_count": "00",
      "wishlist_count": "00",
      
    });
  } on FirebaseAuthException catch (e) {
    VxToast.show(context, msg: e.toString());
  }
}
