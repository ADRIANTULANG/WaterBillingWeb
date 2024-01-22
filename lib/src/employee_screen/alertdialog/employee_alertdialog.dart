import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/employee_screen/controller/employee_controller.dart';

class EmployeeAlertDialogs {
  static showAddEmployee({required EmployeeController controller}) {
    RxString dropdwonValue = 'Maintenance Man'.obs;
    TextEditingController firstname = TextEditingController();
    TextEditingController lastname = TextEditingController();
    TextEditingController contactno = TextEditingController();
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    Get.dialog(AlertDialog(
      title: const Text(
        "Add Employee",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 70.h,
        width: 80.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 2.w,
                      ),
                      child: Text(
                        "First Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 4.sp),
                      ),
                    ),
                    SizedBox(
                      height: .5.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 2.w,
                      ),
                      height: 7.h,
                      width: 38.w,
                      child: TextField(
                        onChanged: (value) {},
                        controller: firstname,
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
                        "Last Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 4.sp),
                      ),
                    ),
                    SizedBox(
                      height: .5.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        right: 2.w,
                      ),
                      height: 7.h,
                      width: 38.w,
                      child: TextField(
                        onChanged: (value) {},
                        controller: lastname,
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
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              child: Text(
                "Contact no",
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
                controller: contactno,
                onChanged: (value) {
                  if (contactno.text.isEmpty) {
                  } else {
                    if (contactno.text[0] != "9" ||
                        contactno.text.length > 10) {
                      contactno.clear();
                    } else {}
                  }
                },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 2.w,
                      ),
                      child: Text(
                        "User name",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 4.sp),
                      ),
                    ),
                    SizedBox(
                      height: .5.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 2.w,
                      ),
                      height: 7.h,
                      width: 38.w,
                      child: TextField(
                        onChanged: (value) {},
                        controller: username,
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
                        "Password",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 4.sp),
                      ),
                    ),
                    SizedBox(
                      height: .5.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        right: 2.w,
                      ),
                      height: 7.h,
                      width: 38.w,
                      child: TextField(
                        obscureText: true,
                        onChanged: (value) {},
                        controller: password,
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
                  ],
                ),
              ],
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
                    items: ['Maintenance Man', 'Meter Reader']
                        .map<DropdownMenuItem<String>>((String value) {
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
                onPressed: () {
                  if (firstname.text.isEmpty ||
                      lastname.text.isEmpty ||
                      username.text.isEmpty ||
                      password.text.isEmpty ||
                      contactno.text.isEmpty) {
                    Get.snackbar("Message", "Missing input",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM);
                  } else if (contactno.text.length != 10 ||
                      contactno.text[0] != "9") {
                    Get.snackbar("Message", "Invalid number",
                        backgroundColor: Colors.red, colorText: Colors.white);
                  } else {
                    controller.addEmployee(
                        firstname: firstname.text,
                        lastname: lastname.text,
                        contactno: contactno.text,
                        type: dropdwonValue.value,
                        username: username.text,
                        password: password.text);
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
                        "Add Employee",
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
      {required EmployeeController controller, required String docid}) async {
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

  static showEditEmployee({
    required EmployeeController controller,
    required String fname,
    required String lname,
    required String oldContact,
    required String oldUsername,
    required String oldPassword,
    required String type,
    required String docid,
  }) {
    RxString dropdwonValue = type.obs;
    TextEditingController firstname = TextEditingController(text: fname);
    TextEditingController lastname = TextEditingController(text: lname);
    TextEditingController contactno = TextEditingController(text: oldContact);
    TextEditingController username = TextEditingController(text: oldUsername);
    TextEditingController password = TextEditingController(text: oldPassword);
    Get.dialog(AlertDialog(
      title: const Text(
        "Edit Employee",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 70.h,
        width: 80.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 2.w,
                      ),
                      child: Text(
                        "First Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 4.sp),
                      ),
                    ),
                    SizedBox(
                      height: .5.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 2.w,
                      ),
                      height: 7.h,
                      width: 38.w,
                      child: TextField(
                        onChanged: (value) {},
                        controller: firstname,
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
                        "Last Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 4.sp),
                      ),
                    ),
                    SizedBox(
                      height: .5.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        right: 2.w,
                      ),
                      height: 7.h,
                      width: 38.w,
                      child: TextField(
                        onChanged: (value) {},
                        controller: lastname,
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
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              child: Text(
                "Contact no",
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
                controller: contactno,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 2.w,
                      ),
                      child: Text(
                        "User name",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 4.sp),
                      ),
                    ),
                    SizedBox(
                      height: .5.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 2.w,
                      ),
                      height: 7.h,
                      width: 38.w,
                      child: TextField(
                        onChanged: (value) {},
                        controller: username,
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
                        "Password",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 4.sp),
                      ),
                    ),
                    SizedBox(
                      height: .5.h,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        right: 2.w,
                      ),
                      height: 7.h,
                      width: 38.w,
                      child: TextField(
                        obscureText: true,
                        onChanged: (value) {},
                        controller: password,
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
                  ],
                ),
              ],
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
                    items: ['Maintenance Man', 'Meter Reader']
                        .map<DropdownMenuItem<String>>((String value) {
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
                onPressed: () {
                  if (firstname.text.isEmpty ||
                      lastname.text.isEmpty ||
                      username.text.isEmpty ||
                      password.text.isEmpty ||
                      contactno.text.isEmpty) {
                    Get.snackbar("Message", "Missing input",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM);
                  } else {
                    controller.editCharges(
                        docid: docid,
                        fname: firstname.text,
                        lname: lastname.text,
                        contactno: contactno.text,
                        type: dropdwonValue.value,
                        username: username.text,
                        password: password.text);
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
                        "Edit Employee",
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
