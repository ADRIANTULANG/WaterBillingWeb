import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/other_charges_screen/controller/other_charger_controller.dart';

import '../alertdialog/other_charges_alertdialog.dart';

class OtherChargesListView extends GetView<OtherChargesController> {
  const OtherChargesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.otherChargesList.isEmpty
          ? const Center(
              child: Text("No available data."),
            )
          : ListView.builder(
              itemCount: controller.otherChargesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(left: 1.w, right: 1.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                controller
                                    .otherChargesList[index].accountnumber,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                controller.otherChargesList[index].chargetype,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                controller.otherChargesList[index].amount,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                DateFormat.yMMMd().format(controller
                                    .otherChargesList[index].datecreated),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                controller.otherChargesList[index].status,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PopupMenuButton(
                                itemBuilder: (context) => <PopupMenuEntry>[
                                  PopupMenuItem(
                                    onTap: () {
                                      if (controller
                                              .otherChargesList[index].status ==
                                          "Paid") {
                                        controller.updateToPaidOrUnpaid(
                                            docid: controller
                                                .otherChargesList[index].id,
                                            status: "Unpaid");
                                      } else {
                                        controller.updateToPaidOrUnpaid(
                                            docid: controller
                                                .otherChargesList[index].id,
                                            status: "Paid");
                                      }
                                    },
                                    value: controller.otherChargesList[index]
                                                .status ==
                                            "Paid"
                                        ? 'Unpaid'
                                        : "Paid",
                                    child: controller.otherChargesList[index]
                                                .status ==
                                            "Paid"
                                        ? const Text('Unpaid')
                                        : const Text('Paid'),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      OtherChargesAlertDialogs
                                          .showUpdateCharges(
                                        docid: controller
                                            .otherChargesList[index].id,
                                        controller: controller,
                                        type: controller
                                            .otherChargesList[index].chargetype,
                                        accnum: controller
                                            .otherChargesList[index]
                                            .accountnumber,
                                        oldAmount: controller
                                            .otherChargesList[index].amount,
                                      );
                                    },
                                    value: "Edit",
                                    child: const Text('Edit'),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      OtherChargesAlertDialogs.showDeleteOrNot(
                                        controller: controller,
                                        docid: controller
                                            .otherChargesList[index].id,
                                      );
                                    },
                                    value: "Delete",
                                    child: const Text('Delete'),
                                  ),
                                ],
                                child: const Icon(Icons.more_horiz_outlined),
                              ),
                            ),
                          )
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
