import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/dashboard_screen/controller/dashboard_controller.dart';

import '../widget/dashboard_chart_view.dart';
import '../widget/dashboard_recent_activities_view.dart';
import '../widget/dashboard_upper_tabs_button_view.dart';

class DashboardTabView extends GetView<DashboardController> {
  const DashboardTabView({super.key});
  static const String id = "dashboard_tab";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.h,
          ),
          const DashboardUpperTabButtonsView(),
          SizedBox(
            height: 3.h,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Row(
                children: [
                  const DashboardChartView(),
                  SizedBox(
                    width: 1.5.w,
                  ),
                  const DashboardOtherView()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
