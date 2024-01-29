import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/concessionaire_screen/view/concessionaire_view.dart';
import 'package:waterbilling/src/dashboard_screen/controller/dashboard_controller.dart';
import 'package:waterbilling/src/employee_screen/view/employee_view.dart';
import 'package:waterbilling/src/payment_screen/view/payment_view.dart';
import 'package:waterbilling/src/services_request_screen/view/service_request_view.dart';
import 'package:waterbilling/src/water_bill_ledger_screen/view/water_bill_ledger_view.dart';

import '../../../services/getstorage_services.dart';

class DashboardUpperTabButtonsView extends GetView<DashboardController> {
  const DashboardUpperTabButtonsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 100.w,
      child: Padding(
        padding: EdgeInsets.only(
          left: 2.w,
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            InkWell(
              onTap: () {
                controller.selectedScreen.value = ConcessionaireView.id;
                Get.find<StorageServices>()
                    .saveRoute(screen: controller.selectedScreen.value);
                // controller.readExcelFile();
              },
              child: Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h, left: 1.w),
                child: Container(
                  height: 14.h,
                  width: 18.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey, spreadRadius: 1, blurRadius: 3)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person,
                          size: 8.sp, color: Colors.lightGreen[900]),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        "Concessionaire",
                        style: TextStyle(
                            fontFamily: "BariolBold",
                            fontSize: 3.sp,
                            color: Colors.lightGreen[900]),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            InkWell(
              onTap: () {
                controller.selectedScreen.value = WaterBillLedgerView.id;
                Get.find<StorageServices>()
                    .saveRoute(screen: controller.selectedScreen.value);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: Container(
                  height: 14.h,
                  width: 18.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey, spreadRadius: 1, blurRadius: 3)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.water,
                          size: 8.sp, color: Colors.lightGreen[900]),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        "Water Bill",
                        style: TextStyle(
                            fontFamily: "BariolBold",
                            fontSize: 3.sp,
                            color: Colors.lightGreen[900]),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   width: 2.w,
            // ),
            // InkWell(
            //   onTap: () {
            //     controller.selectedScreen.value = OtherChargesView.id;
            //     Get.find<StorageServices>()
            //         .saveRoute(screen: controller.selectedScreen.value);
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
            //     child: Container(
            //       height: 14.h,
            //       width: 18.w,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(8),
            //           color: Colors.white,
            //           boxShadow: const [
            //             BoxShadow(
            //                 color: Colors.grey, spreadRadius: 1, blurRadius: 3)
            //           ]),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Icon(Icons.receipt,
            //               size: 8.sp, color: Colors.lightGreenAccent),
            //           SizedBox(
            //             width: 1.w,
            //           ),
            //           Text(
            //             "Other Charges",
            //             style: TextStyle(
            //                 fontFamily: "BariolBold",
            //                 fontSize: 3.sp,
            //                 color: Colors.lightGreenAccent),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              width: 2.w,
            ),
            InkWell(
              onTap: () {
                controller.selectedScreen.value = ServiceRequestView.id;
                Get.find<StorageServices>()
                    .saveRoute(screen: controller.selectedScreen.value);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: Container(
                  height: 14.h,
                  width: 18.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey, spreadRadius: 1, blurRadius: 3)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.request_page_rounded,
                          size: 8.sp, color: Colors.lightGreen[900]),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        "Service Request",
                        style: TextStyle(
                            fontFamily: "BariolBold",
                            fontSize: 3.sp,
                            color: Colors.lightGreen[900]),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            InkWell(
              onTap: () {
                controller.selectedScreen.value = PaymentView.id;
                Get.find<StorageServices>()
                    .saveRoute(screen: controller.selectedScreen.value);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: Container(
                  height: 14.h,
                  width: 18.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey, spreadRadius: 1, blurRadius: 3)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long,
                          size: 8.sp, color: Colors.lightGreen[900]),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        "Payments",
                        style: TextStyle(
                            fontFamily: "BariolBold",
                            fontSize: 3.sp,
                            color: Colors.lightGreen[900]),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            InkWell(
              onTap: () {
                controller.selectedScreen.value = EmployeeView.id;
                Get.find<StorageServices>()
                    .saveRoute(screen: controller.selectedScreen.value);
              },
              child: Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: Container(
                  height: 14.h,
                  width: 18.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey, spreadRadius: 1, blurRadius: 3)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.group,
                          size: 8.sp, color: Colors.lightGreen[900]),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        "Employees",
                        style: TextStyle(
                            fontFamily: "BariolBold",
                            fontSize: 3.sp,
                            color: Colors.lightGreen[900]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
