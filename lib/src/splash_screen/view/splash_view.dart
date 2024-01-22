import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/splash_screen/controller/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  static const String id = "splash";
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            EdgeInsets.only(top: 30.h, bottom: 30.h, left: 30.w, right: 30.w),
        child: Container(
          height: 100.w,
          width: 100.w,
          decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage("assets/images/logo.png"))),
        ),
      ),
    );
  }
}
