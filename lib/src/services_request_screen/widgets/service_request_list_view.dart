import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/services/getstorage_services.dart';
import 'package:waterbilling/src/services_request_screen/controller/service_request_controller.dart';
import 'package:waterbilling/src/services_request_screen/pdf/service_request_mo_pdf.dart';

import '../alertdialog/service_request_alertdialog.dart';

class ServiceRequestListView extends GetView<ServiceRequestController> {
  const ServiceRequestListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.serviceRequestList.isEmpty
          ? const Center(
              child: Text("No available data."),
            )
          : ListView.builder(
              itemCount: controller.serviceRequestList.length,
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
                                    .serviceRequestList[index].accountNumber,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "${controller.serviceRequestList[index].firstname} ${controller.serviceRequestList[index].lastname}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                controller.serviceRequestList[index].address,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                controller
                                    .serviceRequestList[index].serviceType,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                controller.serviceRequestList[index]
                                            .employeeName ==
                                        ""
                                    ? "-----"
                                    : controller
                                        .serviceRequestList[index].employeeName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                controller.serviceRequestList[index].remarks ==
                                        ""
                                    ? "-----"
                                    : controller
                                        .serviceRequestList[index].remarks,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                DateFormat.yMMMd().format(controller
                                    .serviceRequestList[index].datecreated),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: InkWell(
                                  onTap: () {
                                    if (Get.find<StorageServices>()
                                            .storage
                                            .read('role') ==
                                        "frontliner") {
                                      ServiceRequestMissionOrderPdf.createPdf(
                                          requestdata: controller
                                              .serviceRequestList[index]);
                                    } else {
                                      Get.snackbar("Message",
                                          "Sorry. only the frontliners can create a mission order.",
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white);
                                    }
                                  },
                                  child: const Icon(Icons.download)),
                            ),
                          ),
                          controller.serviceRequestList[index].status ==
                                      false &&
                                  controller.serviceRequestList[index]
                                          .statusstring ==
                                      ""
                              ? Expanded(
                                  child: Center(
                                    child: PopupMenuButton(
                                      itemBuilder: (context) =>
                                          <PopupMenuEntry>[
                                        PopupMenuItem(
                                          onTap: () {
                                            if (Get.find<StorageServices>()
                                                    .storage
                                                    .read('role') ==
                                                "frontliner") {
                                              ServiceRequestAlertDialog
                                                  .showDialogAssignTo(
                                                      accountNumber: controller
                                                          .serviceRequestList[
                                                              index]
                                                          .accountNumber,
                                                      type: controller
                                                          .serviceRequestList[
                                                              index]
                                                          .serviceType,
                                                      requestID: controller
                                                          .serviceRequestList[
                                                              index]
                                                          .id,
                                                      controller: controller);
                                            } else {
                                              Get.snackbar("Message",
                                                  "Sorry. only the frontliners can evaluate a request.",
                                                  backgroundColor: Colors.green,
                                                  colorText: Colors.white);
                                            }
                                          },
                                          value: true,
                                          child: const Text('Accept'),
                                        ),
                                        PopupMenuItem(
                                          onTap: () {
                                            if (Get.find<StorageServices>()
                                                    .storage
                                                    .read('role') ==
                                                "frontliner") {
                                              controller.updateRejectStatus(
                                                  requestID: controller
                                                      .serviceRequestList[index]
                                                      .id);
                                              controller.sendNotif(
                                                clientmessage:
                                                    "Dear client, the service request '${controller.serviceRequestList[index].serviceType}' you requested has been rejected.",
                                                employeemessage: "",
                                                accountNumber: controller
                                                    .serviceRequestList[index]
                                                    .accountNumber,
                                                status: false,
                                                employeeID: "",
                                              );
                                            } else {
                                              Get.snackbar("Message",
                                                  "Sorry. only the frontliners can evaluate a request.",
                                                  backgroundColor: Colors.green,
                                                  colorText: Colors.white);
                                            }
                                          },
                                          value: false,
                                          child: const Text('Reject'),
                                        ),
                                      ],
                                      child:
                                          const Icon(Icons.more_horiz_outlined),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  child: Center(
                                    child: Text(
                                      controller.serviceRequestList[index]
                                          .statusstring,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
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
