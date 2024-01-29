import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/services/getstorage_services.dart';
import 'package:waterbilling/src/water_bill_ledger_screen/controller/water_bill_ledger_controller.dart';

import '../widgets/water_bill_ledger_header_view.dart';
import '../widgets/water_bill_ledger_list_view.dart';

class WaterBillLedgerView extends GetView<WaterBillLedgerController> {
  const WaterBillLedgerView({super.key});
  static const String id = "waterbill";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Padding(
      padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Water Billing",
                style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.lightGreen[900])),
                      onPressed: () {
                        if (controller.isWaterBillError.value == false) {
                          if (Get.find<StorageServices>()
                                  .storage
                                  .read('role') ==
                              "admin") {
                            controller.readExcelFilePaymentCollection();
                          } else {
                            Get.snackbar("Message",
                                "Sorry. only the admin can upload payments.",
                                backgroundColor: Colors.green,
                                colorText: Colors.white);
                          }
                        } else {
                          Get.snackbar("Message",
                              "Sorry. Something went wrong with the billing data please contact admin to check the data. Thank you.",
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        }
                      },
                      child: const Text(
                        "Upload Payment",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                  SizedBox(
                    width: 1.5.w,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.lightGreen[900])),
                      onPressed: () {
                        if (controller.isWaterBillError.value == false) {
                          if (Get.find<StorageServices>()
                                  .storage
                                  .read('role') ==
                              "admin") {
                            controller.readExcelFileBilling();
                          } else {
                            Get.snackbar("Message",
                                "Sorry. only the admin can upload billings.",
                                backgroundColor: Colors.green,
                                colorText: Colors.white);
                          }
                        } else {
                          Get.snackbar("Message",
                              "Sorry. Something went wrong with the billing data please contact admin to check the data. Thank you.",
                              backgroundColor: Colors.red,
                              colorText: Colors.white);
                        }
                      },
                      child: const Text(
                        "Upload Billing",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                  SizedBox(
                    width: 1.5.w,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.lightGreen[900])),
                    onPressed: () {
                      controller.getWaterBills();
                    },
                    child: const Icon(Icons.refresh_rounded),
                  )
                ],
              )
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
                  const WaterBillLedgerHeaderView(),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Expanded(
                    child: SizedBox(
                      child: WaterBillLedgerListView(),
                    ),
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
