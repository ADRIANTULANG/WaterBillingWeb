import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/dashboard_screen/controller/dashboard_controller.dart';

class DashboardOtherView extends GetView<DashboardController> {
  const DashboardOtherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      width: 26.5.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 3)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: 2.w, right: 2.w, top: 3.h, bottom: 1.h),
            child: Text(
              "Recent Activities",
              style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.activitiesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 1.w, top: 2.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 1.w,
                          backgroundColor: Colors.lightGreen[900],
                          child: Center(
                            child: Text(
                              controller
                                  .activitiesList[index].username[0].capitalize
                                  .toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(controller.activitiesList[index].activity)
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
