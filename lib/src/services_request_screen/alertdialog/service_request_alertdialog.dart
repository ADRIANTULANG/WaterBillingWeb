import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/models/employees_model.dart';
import 'package:waterbilling/src/services_request_screen/controller/service_request_controller.dart';

class ServiceRequestAlertDialog {
  static showLoadingDialog() {
    Get.dialog(const AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // The loading indicator
            CircularProgressIndicator(),
            SizedBox(
              height: 15,
            ),
            // Some text
            Text('Loading...')
          ],
        ),
      ),
    ));
  }

  static showDialogAssignTo(
      {required ServiceRequestController controller,
      required String requestID,
      required String accountNumber,
      required String type}) {
    Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      title: Text(
        "Assign Request",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 4.sp),
      ),
      content: SizedBox(
        height: 35.h,
        width: 40.w,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: Text(
                  "Select employee to assign.",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 4.sp),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: Container(
                  height: 7.h,
                  width: 100.w,
                  color: const Color(0xFFF0EEEE),
                  child: Obx(() => DropdownButton<Employees>(
                        value: controller.selectedEmployee,
                        padding: EdgeInsets.only(left: 1.w),
                        underline: const SizedBox(),
                        elevation: 16,
                        isExpanded: true,
                        onChanged: (Employees? value) {
                          controller.selectedEmployee = value!;
                        },
                        items: controller.employeeesList
                            .map<DropdownMenuItem<Employees>>(
                                (Employees employee) {
                          return DropdownMenuItem<Employees>(
                            value: employee,
                            child: Text(
                                "${employee.firstname} ${employee.lastname} - ${employee.type}"),
                          );
                        }).toList(),
                      )),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: SizedBox(
                  height: 7.h,
                  width: 100.w,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.lightGreen[900])),
                      onPressed: () {
                        controller.updateStatusAndAssign(
                            employeeID: controller.selectedEmployee!.id,
                            employeeName:
                                "${controller.selectedEmployee!.firstname} ${controller.selectedEmployee!.lastname}",
                            requestID: requestID);
                        controller.sendNotif(
                          clientmessage:
                              "Dear client, the service request '$type' you requested has been approved.",
                          employeemessage:
                              "Dear employee, there is a service request '$type' assigned to you. Please check it and take action.",
                          accountNumber: accountNumber,
                          status: true,
                          employeeID: controller.selectedEmployee!.id,
                        );
                      },
                      child: const Text("Submit")),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
