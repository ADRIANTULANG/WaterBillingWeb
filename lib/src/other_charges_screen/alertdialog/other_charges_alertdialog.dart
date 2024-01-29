import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/other_charges_screen/controller/other_charger_controller.dart';

class OtherChargesAlertDialogs {
  static showAddCharges({required OtherChargesController controller}) {
    RxString dropdwonValue = 'A/R Others'.obs;
    TextEditingController accountnumber = TextEditingController();
    TextEditingController amount = TextEditingController();

    Get.dialog(AlertDialog(
      title: const Text(
        "Add Charges",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 60.h,
        width: 80.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              child: Text(
                "Account no",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 4.sp),
              ),
            ),
            SizedBox(
              height: .5.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              height: 7.h,
              width: 100.w,
              child: TextField(
                controller: accountnumber,
                onChanged: (value) {},
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
                "Amount",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 4.sp),
              ),
            ),
            SizedBox(
              height: .5.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              height: 7.h,
              width: 100.w,
              child: TextField(
                controller: amount,
                onChanged: (value) {},
                onEditingComplete: () {
                  // controller.login(
                  //     username: controller.username.text,
                  //     password:a controller.password.text);
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
                "Type",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 4.sp),
              ),
            ),
            SizedBox(
              height: .5.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              child: Container(
                height: 7.h,
                width: 100.w,
                color: const Color(0xFFF0EEEE),
                child: Obx(
                  () => DropdownButton<String>(
                    value: dropdwonValue.value,
                    padding: EdgeInsets.only(
                      left: 1.w,
                    ),
                    underline: const SizedBox(),
                    elevation: 16,
                    isExpanded: true,
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      dropdwonValue.value = value!;
                    },
                    items: [
                      'A/R Others',
                      'Fines',
                      'Materials',
                      'Meters',
                      'Reopening Fee',
                      'Service Guarantee'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightGreen[900])),
                onPressed: () {
                  if (accountnumber.text.isEmpty) {
                    Get.snackbar("Message", "Missing input",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM);
                  } else {
                    controller.createCharges(
                        accountnumber: accountnumber.text,
                        type: dropdwonValue.value,
                        amount: amount.text);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 1.w, bottom: 1.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_add_alt_1,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      const Text(
                        "Add Charges",
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
    ));
  }

  static showDeleteOrNot(
      {required OtherChargesController controller,
      required String docid}) async {
    Get.dialog(AlertDialog(
        title: Text(
          "Message",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 4.sp,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "No",
                style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.h, right: 2.w),
            child: TextButton(
              onPressed: () {
                controller.deleteData(docid: docid);
              },
              child: Text(
                "Yes",
                style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
        content: SizedBox(
          height: 10.h,
          width: 20.w,
          child: Text(
            "Are you sure you want to delete this data?",
            style: TextStyle(fontSize: 4.sp),
          ),
        )));
  }

  static showUpdateCharges({
    required OtherChargesController controller,
    required String type,
    required String accnum,
    required String oldAmount,
    required String docid,
  }) {
    RxString dropdwonValue = type.obs;
    TextEditingController accountnumber = TextEditingController(text: accnum);
    TextEditingController amount = TextEditingController(text: oldAmount);

    Get.dialog(AlertDialog(
      title: const Text(
        "Update Charges",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 60.h,
        width: 80.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              child: Text(
                "Account no",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 4.sp),
              ),
            ),
            SizedBox(
              height: .5.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              height: 7.h,
              width: 100.w,
              child: TextField(
                controller: accountnumber,
                onChanged: (value) {},
                onEditingComplete: () {},
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
                "Amount",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 4.sp),
              ),
            ),
            SizedBox(
              height: .5.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              height: 7.h,
              width: 100.w,
              child: TextField(
                controller: amount,
                onChanged: (value) {},
                onEditingComplete: () {},
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
                "Type",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 4.sp),
              ),
            ),
            SizedBox(
              height: .5.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              child: Container(
                height: 7.h,
                width: 100.w,
                color: const Color(0xFFF0EEEE),
                child: Obx(
                  () => DropdownButton<String>(
                    value: dropdwonValue.value,
                    padding: EdgeInsets.only(
                      left: 1.w,
                    ),
                    underline: const SizedBox(),
                    elevation: 16,
                    isExpanded: true,
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      dropdwonValue.value = value!;
                    },
                    items: [
                      'A/R Others',
                      'Fines',
                      'Materials',
                      'Meters',
                      'Reopening Fee',
                      'Service Guarantee'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightGreen[900])),
                onPressed: () {
                  if (accountnumber.text.isEmpty) {
                    Get.snackbar("Message", "Missing input",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM);
                  } else {
                    controller.editCharges(
                        docid: docid,
                        accountnumber: accountnumber.text,
                        type: dropdwonValue.value,
                        amount: amount.text);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 1.w, bottom: 1.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_add_alt_1,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      const Text(
                        "Update Charges",
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
    ));
  }
}
