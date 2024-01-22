import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/login_screen/controller/login_controller.dart';

class LoginHeaderView extends GetView<LoginController> {
  const LoginHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(children: [
        SizedBox(
          height: 7.h,
          width: 100.w,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 1.w, top: 1.h),
              height: 7.h,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Image.asset("assets/images/logo.png"),
                  SizedBox(
                    width: .5.w,
                  ),
                  Text(
                    "CSR & WBC ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 3.sp,
                        color: Colors.lightGreen),
                  ),
                ],
              ),
            )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 2.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(
                    "Contact us",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 2.5.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(
                    "About us",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 2.5.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 2.5.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                SizedBox(
                  width: 1.w,
                ),
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
