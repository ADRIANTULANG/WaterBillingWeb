import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/water_bill_ledger_screen/controller/water_bill_ledger_controller.dart';

class WaterBillLedgerAlertDialog {
  static showLoadingDialog() {
    Get.dialog(
      const AlertDialog(
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
      ),
    );
  }

  static showDeleteBillDialog(
      {required WaterBillLedgerController controller,
      required String documentID}) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h),
                child: const Text('Are you sure you want to delete this bill?'),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 7.w,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("No")),
                    ),
                    SizedBox(
                      width: 7.w,
                      child: ElevatedButton(
                          onPressed: () {
                            controller.deleteBill(documentID: documentID);
                          },
                          child: const Text("Yes")),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static showEditWaterBill(
      {required String documentID,
      required String clietname,
      required String remainingbalance,
      required String billdate,
      required String duedate,
      required DateTime billdateOrig,
      required DateTime duedateOrig,
      required WaterBillLedgerController controller}) async {
    TextEditingController clientName = TextEditingController(text: clietname);
    TextEditingController balance =
        TextEditingController(text: remainingbalance);
    RxString billingDate = billdate.obs;
    RxString dueDate = duedate.obs;
    DateTime billingDateOrig = billdateOrig;
    DateTime dueDateOrig = duedateOrig;

    Get.dialog(
      AlertDialog(
        title: Text(
          "Edit Bill",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 5.sp),
        ),
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: Text(
                  "Client Name",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 4.sp),
                ),
              ),
              SizedBox(
                height: .5.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                height: 7.h,
                width: 50.w,
                child: TextField(
                  onChanged: (value) {},
                  controller: clientName,
                  onEditingComplete: () {
                    // controller.login(
                    //     username: controller.username.text,
                    //     password: controller.password.text);
                  },
                  decoration: InputDecoration(
                      fillColor: const Color(0xFFF0EEEE),
                      filled: true,
                      contentPadding: EdgeInsets.only(left: .5.w),
                      alignLabelWithHint: false,
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: Text(
                  "Balance",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 4.sp),
                ),
              ),
              SizedBox(
                height: .5.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                height: 7.h,
                width: 50.w,
                child: TextField(
                  onChanged: (value) {},
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]*$')),
                  ],
                  controller: balance,
                  onEditingComplete: () {
                    // controller.login(
                    //     username: controller.username.text,
                    //     password: controller.password.text);
                  },
                  decoration: InputDecoration(
                      fillColor: const Color(0xFFF0EEEE),
                      filled: true,
                      contentPadding: EdgeInsets.only(left: .5.w),
                      alignLabelWithHint: false,
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Billing Date",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 4.sp),
                        ),
                        SizedBox(
                          height: .5.h,
                        ),
                        InkWell(
                          onTap: () async {
                            var billingDateSelected = await showDatePicker(
                                context: Get.context!,
                                initialDate: billingDateOrig,
                                firstDate: DateTime(1950, 1, 1),
                                lastDate: DateTime(2030, 12, 30));
                            if (billingDateSelected != null) {
                              billingDate.value = DateFormat.yMMMd()
                                  .format(billingDateSelected);
                              billingDateOrig = billingDateSelected;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: .5.w, top: 2.h),
                            height: 7.h,
                            width: 22.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF0EEEE),
                            ),
                            child: Obx(() => Text(billingDate.value)),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 2.w,
                          ),
                          child: Text(
                            "Due Date",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 4.sp),
                          ),
                        ),
                        SizedBox(
                          height: .5.h,
                        ),
                        InkWell(
                          onTap: () async {
                            var dueDateSelected = await showDatePicker(
                                context: Get.context!,
                                initialDate: dueDateOrig,
                                firstDate: DateTime(1950, 1, 1),
                                lastDate: DateTime(2030, 12, 30));
                            if (dueDateSelected != null) {
                              dueDate.value =
                                  DateFormat.yMMMd().format(dueDateSelected);
                              dueDateOrig = dueDateSelected;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: .5.w, top: 2.h),
                            height: 7.h,
                            width: 22.w,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF0EEEE),
                            ),
                            child: Obx(() => Text(dueDate.value)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.lightGreen[900])),
                  onPressed: () {
                    if (clientName.text.isEmpty || balance.text.isEmpty) {
                      Get.snackbar("Message", "Missing input",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      controller.editBill(
                          documentID: documentID,
                          clietname: clientName.text,
                          remainingbalance: balance.text,
                          billdate: billingDateOrig,
                          duedate: dueDateOrig);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 1.w, bottom: 1.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        const Text(
                          "Edit Bill",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
