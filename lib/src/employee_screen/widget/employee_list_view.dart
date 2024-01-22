import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/services/getstorage_services.dart';
import 'package:waterbilling/src/employee_screen/alertdialog/employee_alertdialog.dart';
import 'package:waterbilling/src/employee_screen/controller/employee_controller.dart';

class EmployeesListView extends GetView<EmployeeController> {
  const EmployeesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.employeeesList.isEmpty
          ? const Center(
              child: Text("No available data."),
            )
          : ListView.builder(
              itemCount: controller.employeeesList.length,
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
                                controller.employeeesList[index].firstname,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                controller.employeeesList[index].lastname,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                controller.employeeesList[index].type,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                controller.employeeesList[index].contactno,
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
                                      if (Get.find<StorageServices>()
                                              .storage
                                              .read('role') ==
                                          "admin") {
                                        EmployeeAlertDialogs.showEditEmployee(
                                            controller: controller,
                                            fname: controller
                                                .employeeesList[index]
                                                .firstname,
                                            lname: controller
                                                .employeeesList[index].lastname,
                                            oldContact: controller
                                                .employeeesList[index]
                                                .contactno,
                                            oldUsername: controller
                                                .employeeesList[index].username,
                                            oldPassword: controller
                                                .employeeesList[index].password,
                                            type: controller
                                                .employeeesList[index].type,
                                            docid: controller
                                                .employeeesList[index].id);
                                      } else {
                                        Get.snackbar("Message",
                                            "Sorry. only the admin can edit an employee.",
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white);
                                      }
                                    },
                                    value: "Edit",
                                    child: const Text('Edit'),
                                  ),
                                  PopupMenuItem(
                                    onTap: () {
                                      if (Get.find<StorageServices>()
                                              .storage
                                              .read('role') ==
                                          "admin") {
                                        EmployeeAlertDialogs.showDeleteOrNot(
                                            controller: controller,
                                            docid: controller
                                                .employeeesList[index].id);
                                      } else {
                                        Get.snackbar("Message",
                                            "Sorry. only the admin can delete an employee.",
                                            backgroundColor: Colors.green,
                                            colorText: Colors.white);
                                      }
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
