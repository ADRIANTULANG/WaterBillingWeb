import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/login_screen/controller/login_controller.dart';

class LoginBodyView extends GetView<LoginController> {
  const LoginBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            "You can start here.",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 3.sp,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 35.w, right: 35.w),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                  borderRadius: BorderRadius.circular(3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: Text(
                      "Email",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 2.5.sp),
                    ),
                  ),
                  SizedBox(
                    height: .5.h,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    height: 7.h,
                    width: 100.w,
                    child: TextField(
                      onChanged: (value) {},
                      onEditingComplete: () {
                        // controller.login(
                        //     username: controller.username.text,
                        //     password: controller.password.text);
                      },
                      controller: controller.username,
                      decoration: InputDecoration(
                          fillColor: const Color(0xFFF0EEEE),
                          filled: true,
                          contentPadding: EdgeInsets.only(left: .5.w),
                          alignLabelWithHint: false,
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: Text(
                      "Password",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 2.5.sp),
                    ),
                  ),
                  SizedBox(
                    height: .5.h,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    height: 7.h,
                    width: 100.w,
                    child: TextField(
                      onChanged: (value) {},
                      onEditingComplete: () {
                        // controller.login(
                        //     username: controller.username.text,
                        //     password: controller.password.text);
                      },
                      obscureText: true,
                      controller: controller.password,
                      decoration: InputDecoration(
                          fillColor: const Color(0xFFF0EEEE),
                          filled: true,
                          contentPadding: EdgeInsets.only(left: .5.w),
                          alignLabelWithHint: false,
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: InkWell(
                      onTap: () {
                        if (controller.isAllowed.value == true) {
                          controller.login();
                        } else {
                          Get.snackbar(
                              "Message", "The system is not allowed for demo.",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM);
                        }
                        // controller.login(
                        //     username: controller.username.text,
                        //     password: controller.password.text);
                      },
                      child: Container(
                        height: 6.h,
                        width: 100.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.lightGreen[900],
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 3.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              ),
            ),
          ),

          // Obx(() => controller.isLoginView.value == true
          //     ? const LoginView()
          //     : RegisterView()),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Text(
              "Forgot your password?",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 2.2.sp,
                  color: Colors.lightGreen),
            ),
          )),
        ],
      ),
    );
  }
}
