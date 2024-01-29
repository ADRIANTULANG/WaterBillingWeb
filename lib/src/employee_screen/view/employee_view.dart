import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/services/getstorage_services.dart';
import 'package:waterbilling/src/employee_screen/alertdialog/employee_alertdialog.dart';

import '../controller/employee_controller.dart';
import '../widget/employee_header_view.dart';
import '../widget/employee_list_view.dart';

class EmployeeView extends GetView<EmployeeController> {
  const EmployeeView({super.key});
  static const String id = "employee";
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
                "Employee",
                style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.lightGreen[900])),
                    onPressed: () {
                      if (Get.find<StorageServices>().storage.read('role') ==
                          "admin") {
                        EmployeeAlertDialogs.showAddEmployee(
                            controller: controller);
                      } else {
                        Get.snackbar("Message",
                            "Sorry. only the admin can add an employee.",
                            backgroundColor: Colors.green,
                            colorText: Colors.white);
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_add_alt_1,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 0.5.w,
                        ),
                        const Text(
                          "Add Employee",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 1.5.w,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.lightGreen[900])),
                    onPressed: () {
                      controller.getEmployees();
                    },
                    child: const Icon(Icons.refresh_rounded),
                  )
                ],
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
                  const EmployeeHeaderView(),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Expanded(
                    child: SizedBox(child: EmployeesListView()),
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
