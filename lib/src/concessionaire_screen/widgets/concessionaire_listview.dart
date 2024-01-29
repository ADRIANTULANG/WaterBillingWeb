import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/services/getstorage_services.dart';

import '../controller/concessionaire_controller.dart';

class ConcessionaireListView extends GetView<ConcessionaireController> {
  const ConcessionaireListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.usersList.isEmpty
          ? const Center(
              child: Text("No available data."),
            )
          : ListView.builder(
              itemCount: controller.usersList.length,
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
                                controller.usersList[index].accountnumber,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                controller.usersList[index].firstname,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                controller.usersList[index].lastname,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                controller.usersList[index].contactno,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: InkWell(
                                  onTap: () {
                                    controller.downloadUrl(
                                        url: controller
                                            .usersList[index].urlLink);
                                  },
                                  child: const Icon(Icons.download)),
                            ),
                          ),
                          controller.usersList[index].isAccepted == false &&
                                  controller.usersList[index].status == ""
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
                                                "admin") {
                                              controller.acceptRejectUser(
                                                  action: true,
                                                  docid: controller
                                                      .usersList[index].id);
                                              controller.notifyConcessionaire(
                                                  fcmToken: controller
                                                      .usersList[index]
                                                      .fcmToken,
                                                  message:
                                                      "Dear client, your account has been approved by the admin");
                                            } else {
                                              Get.snackbar("Message",
                                                  "Sorry. only the admin can evaluate a concessionaire",
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
                                                "admin") {
                                              controller.acceptRejectUser(
                                                  action: false,
                                                  docid: controller
                                                      .usersList[index].id);
                                              controller.notifyConcessionaire(
                                                  fcmToken: controller
                                                      .usersList[index]
                                                      .fcmToken,
                                                  message:
                                                      "Dear client, your account has been rejected by the admin");
                                            } else {
                                              Get.snackbar("Message",
                                                  "Sorry. only the admin can evaluate a concessionaire",
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
                                      controller.usersList[index].status,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: controller.usersList[index]
                                                      .status ==
                                                  "Accepted"
                                              ? Colors.lightGreen
                                              : Colors.red),
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
