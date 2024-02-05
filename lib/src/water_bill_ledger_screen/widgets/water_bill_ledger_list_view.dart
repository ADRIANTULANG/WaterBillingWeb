import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/services/getstorage_services.dart';
import 'package:waterbilling/src/water_bill_ledger_screen/controller/water_bill_ledger_controller.dart';
import 'package:intl/intl.dart';

import '../alertdialog/water_bill_ledger_alertdialog.dart';

class WaterBillLedgerListView extends GetView<WaterBillLedgerController> {
  const WaterBillLedgerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.waterBillList.isEmpty
          ? const Center(
              child: Text("No available data."),
            )
          : ListView.builder(
              itemCount: controller.waterBillList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(left: 1.w, right: 1.w),
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: InkWell(
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: controller
                                          .waterBillList[index].accountNumber));
                                  Get.snackbar(
                                      "Message", "Text copied to clip board",
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.TOP);
                                },
                                child: Text(
                                  controller.waterBillList[index].accountNumber,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: InkWell(
                                onTap: () async {
                                  await Clipboard.setData(ClipboardData(
                                      text: controller
                                          .waterBillList[index].clientName));
                                  Get.snackbar(
                                      "Message", "Text copied to clip board",
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white,
                                      snackPosition: SnackPosition.TOP);
                                },
                                child: Text(
                                  controller.waterBillList[index].clientName,
                                  // controller.waterBillList[index].bil.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                controller.waterBillList[index].amount
                                    .toStringAsFixed(2),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                DateFormat.yMMMd().format(controller
                                    .waterBillList[index].billingDateTimeStamp),
                                // controller.waterBillList[index].bil.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                DateFormat.yMMMd().format(
                                    controller.waterBillList[index].dueDate),
                                // controller.waterBillList[index].bil.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          controller.waterBillList[index].isDue
                              ? Expanded(
                                  child: Center(
                                      child: Padding(
                                    padding: EdgeInsets.only(
                                        left: .3.w, right: .3.w),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.lightGreen[900])),
                                      onPressed: () {
                                        if (Get.find<StorageServices>()
                                                .storage
                                                .read('role') ==
                                            "admin") {
                                          controller.sendNotif(
                                              method: "Due notification",
                                              accountNumber: controller
                                                  .waterBillList[index]
                                                  .accountNumber,
                                              message:
                                                  "Dear client, we just want to inform you that you still have ${controller.waterBillList[index].amount} pesos that you need to pay. Due date is ${DateFormat.yMMMd().format(controller.waterBillList[index].billingDateTimeStamp)}. Thank you.");
                                        } else {
                                          Get.snackbar("Message",
                                              "Sorry. only the admin can notify users.",
                                              backgroundColor: Colors.green,
                                              colorText: Colors.white);
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Due ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 0.02.w,
                                          ),
                                          Icon(
                                            Icons.notification_add,
                                            color: Colors.white,
                                            size: 3.5.sp,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                                )
                              : const Expanded(
                                  child: Center(
                                    child: Text(
                                      " --- ",
                                      // controller.waterBillList[index].bil.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                          Expanded(
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.only(left: .3.w, right: .3.w),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.lightGreen[900])),
                                onPressed: () {
                                  if (Get.find<StorageServices>()
                                          .storage
                                          .read('role') ==
                                      "admin") {
                                    WaterBillLedgerAlertDialog.showEditWaterBill(
                                        controller: controller,
                                        documentID:
                                            controller.waterBillList[index].id,
                                        clietname: controller
                                            .waterBillList[index].clientName,
                                        remainingbalance: controller
                                            .waterBillList[index].amount
                                            .toStringAsFixed(2),
                                        billdate: DateFormat.yMMMd().format(
                                            controller.waterBillList[index]
                                                .billingDateTimeStamp),
                                        duedate: DateFormat.yMMMd().format(
                                            controller
                                                .waterBillList[index].dueDate),
                                        duedateOrig: controller
                                            .waterBillList[index].dueDate,
                                        billdateOrig: controller
                                            .waterBillList[index]
                                            .billingDateTimeStamp);
                                  } else {
                                    Get.snackbar("Message",
                                        "Sorry. only the admin can edit a bill.",
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Edit ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 0.02.w,
                                    ),
                                    Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 3.5.sp,
                                    )
                                  ],
                                ),
                              ),
                            )),
                          ),
                          Expanded(
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.only(left: .3.w, right: .3.w),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.lightGreen[900])),
                                onPressed: () {
                                  if (Get.find<StorageServices>()
                                          .storage
                                          .read('role') ==
                                      "admin") {
                                    WaterBillLedgerAlertDialog
                                        .showDeleteBillDialog(
                                      controller: controller,
                                      documentID:
                                          controller.waterBillList[index].id,
                                    );
                                  } else {
                                    Get.snackbar("Message",
                                        "Sorry. only the admin can delete a bill.",
                                        backgroundColor: Colors.green,
                                        colorText: Colors.white);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Delete ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 0.02.w,
                                    ),
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 3.5.sp,
                                    )
                                  ],
                                ),
                              ),
                            )),
                          ),
                          controller.waterBillList[index].isPenaltyAdded
                              ? const Expanded(
                                  child: Center(
                                    child: Text(
                                      " --- ",
                                      // controller.waterBillList[index].bil.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Center(
                                      child: Padding(
                                    padding: EdgeInsets.only(
                                        left: .3.w, right: .3.w),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.lightGreen[900])),
                                      onPressed: () {
                                        if (Get.find<StorageServices>()
                                                .storage
                                                .read('role') ==
                                            "admin") {
                                          controller.addPenalty(
                                              docID: controller
                                                  .waterBillList[index].id,
                                              amount: controller
                                                  .waterBillList[index].amount);
                                        } else {
                                          Get.snackbar("Message",
                                              "Sorry. only the admin can delete a bill.",
                                              backgroundColor: Colors.green,
                                              colorText: Colors.white);
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Penalty ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 0.02.w,
                                          ),
                                          Icon(
                                            Icons.warning,
                                            color: Colors.white,
                                            size: 3.5.sp,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                                ),
                          controller.waterBillList[index].isInterestAdded
                              ? const Expanded(
                                  child: Center(
                                    child: Text(
                                      " --- ",
                                      // controller.waterBillList[index].bil.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Center(
                                      child: Padding(
                                    padding: EdgeInsets.only(
                                        left: .3.w, right: .3.w),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.lightGreen[900])),
                                      onPressed: () {
                                        if (Get.find<StorageServices>()
                                                .storage
                                                .read('role') ==
                                            "admin") {
                                          controller.addInterest(
                                              docID: controller
                                                  .waterBillList[index].id,
                                              amount: controller
                                                  .waterBillList[index].amount);
                                        } else {
                                          Get.snackbar("Message",
                                              "Sorry. only the admin can delete a bill.",
                                              backgroundColor: Colors.green,
                                              colorText: Colors.white);
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Interest ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 0.02.w,
                                          ),
                                          Icon(
                                            Icons.percent,
                                            color: Colors.white,
                                            size: 3.5.sp,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
