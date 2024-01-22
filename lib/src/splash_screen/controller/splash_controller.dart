import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waterbilling/services/getstorage_services.dart';
import 'package:waterbilling/src/dashboard_screen/view/dashboard_view.dart';
import 'package:waterbilling/src/login_screen/view/login_view.dart';

class SplashController extends GetxController {
  navigateTo() async {
    Timer(const Duration(seconds: 3), () {
      if (Get.find<StorageServices>().storage.read('id') == null) {
        Get.toNamed(LoginView.id);
      } else {
        Get.toNamed(DashboardView.id);
      }
    });
  }

  RxBool isAllowed = false.obs;

  getDemoAllowed() async {
    try {
      var res = await FirebaseFirestore.instance.collection('demo').get();
      var demo = res.docs;
      if (demo.isNotEmpty) {
        isAllowed.value = demo[0]['isAllowed'];
        if (isAllowed.value == true) {
          navigateTo();
        } else {
          Get.snackbar("Message", "The system is not allowed for demo.",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
        }
      }
    } catch (_) {}
  }

  @override
  void onInit() {
    getDemoAllowed();
    super.onInit();
  }
}
