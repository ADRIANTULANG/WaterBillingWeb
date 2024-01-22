import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/other_charges_screen/controller/other_charger_controller.dart';
import 'package:waterbilling/src/other_charges_screen/widget/other_charges_header_view.dart';

import '../alertdialog/other_charges_alertdialog.dart';
import '../widget/other_charges_list_view.dart';

class OtherChargesView extends GetView<OtherChargesController> {
  const OtherChargesView({super.key});
  static const String id = "othercharges";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Padding(
      padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h),
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Other Charges",
                style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  OtherChargesAlertDialogs.showAddCharges(
                      controller: controller);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.receipt,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 0.5.w,
                    ),
                    const Text(
                      "Add Charge",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, spreadRadius: 1, blurRadius: 3)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  const OtherChargesHeaderView(),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Expanded(
                    child: SizedBox(child: OtherChargesListView()),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
