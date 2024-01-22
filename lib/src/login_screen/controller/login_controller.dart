import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waterbilling/services/getstorage_services.dart';
import 'package:waterbilling/src/dashboard_screen/view/dashboard_tab_view.dart';
import 'package:waterbilling/src/dashboard_screen/view/dashboard_view.dart';

class LoginController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool isAllowed = false.obs;

  getDemoAllowed() async {
    try {
      var res = await FirebaseFirestore.instance.collection('demo').get();
      var demo = res.docs;
      if (demo.isNotEmpty) {
        isAllowed.value = demo[0]['isAllowed'];
      }
    } catch (_) {}
  }

  login() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('admin')
          .where("email", isEqualTo: username.text)
          .get();
      if (res.docs.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: username.text, password: password.text);
        String id = FirebaseAuth.instance.currentUser!.uid;
        String email = FirebaseAuth.instance.currentUser!.email!;
        String role = res.docs[0]['role'];
        Get.find<StorageServices>().saveRoute(screen: DashboardTabView.id);
        Get.find<StorageServices>()
            .saveCredentials(id: id, email: email, role: role);
        Get.toNamed(DashboardView.id);
        Future.delayed(const Duration(seconds: 2), () {
          Get.snackbar("Message", "Welcome!",
              backgroundColor: Colors.green,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        });
      } else {
        Get.snackbar("Message", "User did not exist",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }
    } on Exception catch (e) {
      if (e is FirebaseAuthException) {
        Get.back();
        if (e.code == 'invalid-email') {
          Get.snackbar("Message", "Invalid email format",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          Get.snackbar("Message", "Wrong password",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        } else if (e.code == 'too-many-requests') {
          Get.snackbar("Message",
              "We have blocked all requests from this device due to unusual activity. Try again later",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar("Message", "Login failed",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar("Message", "Login failed}",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  @override
  void onInit() {
    getDemoAllowed();
    super.onInit();
  }
}
