import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/services/getstorage_services.dart';
import 'package:waterbilling/src/water_bill_ledger_screen/controller/water_bill_ledger_controller.dart';
import 'package:intl/intl.dart';

class WaterBillLedgerListView extends GetView<WaterBillLedgerController> {
  const WaterBillLedgerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.waterBillList.isEmpty
          ? const Center(
              child: Text("No available data."),
            )
          :  ListView.builder(
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
                            Get.snackbar("Message", "Text copied to clip board",
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP);
                          },
                          child: Text(
                            controller.waterBillList[index].accountNumber,
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                            Get.snackbar("Message", "Text copied to clip board",
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP);
                          },
                          child: Text(
                            controller.waterBillList[index].clientName,
                            // controller.waterBillList[index].bil.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          controller.waterBillList[index].amount.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          DateFormat.yMMMd().format(controller
                              .waterBillList[index].billingDateTimeStamp),
                          // controller.waterBillList[index].bil.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          DateFormat.yMMMd()
                              .format(controller.waterBillList[index].dueDate),
                          // controller.waterBillList[index].bil.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    controller.waterBillList[index].isDue
                        ? Expanded(
                            child: Center(
                                child: ElevatedButton(
                              onPressed: () {
                                if (Get.find<StorageServices>()
                                        .storage
                                        .read('role') ==
                                    "admin") {
                                  controller.sendNotif(
                                      accountNumber: controller
                                          .waterBillList[index].accountNumber,
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                  const Icon(
                                    Icons.notification_add,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            )),
                          )
                        : const Expanded(
                            child: Center(
                              child: Text(
                                " --- ",
                                // controller.waterBillList[index].bil.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
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
