import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/login_screen/controller/login_controller.dart';

class LoginFooterView extends GetView<LoginController> {
  const LoginFooterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 100.w,
      color: Colors.blue[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "CONTACT US",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 3.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: .5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.email_rounded,
                color: Colors.black,
              ),
              SizedBox(
                width: .5.w,
              ),
              const Text("user@gmail.com"),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "CONNECT WITH US",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 3.sp,
                color: Colors.black),
          ),
          SizedBox(
            height: .5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // controller.launchInBrowserFacebook();
                },
                child: const Icon(
                  Icons.facebook_rounded,
                  color: Colors.lightGreen,
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              InkWell(
                onTap: () async {
                  // controller.launchInBrowserWeChat();
                },
                child: const Icon(
                  Icons.wechat_sharp,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              InkWell(
                onTap: () {
                  // controller.launchInBrowserDiscord();
                },
                child: const Icon(
                  Icons.discord_outlined,
                  color: Colors.purple,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
