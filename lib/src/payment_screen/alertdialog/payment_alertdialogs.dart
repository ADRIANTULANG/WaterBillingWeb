import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/payment_screen/controller/payment_controller.dart';

class PaymentAlertDialogs {
  static showDeletePaymentDialog(
      {required PaymentController controller, required String documentID}) {
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
                child:
                    const Text('Are you sure you want to delete this payment?'),
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
                            controller.deletePayment(documentID: documentID);
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

  static showEditPayment(
      {required String documentID,
      required String clietname,
      required String amount,
      required String reference,
      required PaymentController controller}) async {
    TextEditingController clientName = TextEditingController(text: clietname);
    TextEditingController amountCollected = TextEditingController(text: amount);
    TextEditingController referenceNo = TextEditingController(text: reference);

    Get.dialog(
      AlertDialog(
        title: Text(
          "Edit Payment",
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
                width: 50.w,
                child: TextField(
                  onChanged: (value) {},
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]*$')),
                  ],
                  controller: amountCollected,
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
                  "Reference",
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
                  controller: referenceNo,
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
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.lightGreen[900])),
                  onPressed: () {
                    if (clientName.text.isEmpty ||
                        amountCollected.text.isEmpty ||
                        referenceNo.text.isEmpty) {
                      Get.snackbar("Message", "Missing input",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      controller.editPayment(
                        reference: referenceNo.text,
                        documentID: documentID,
                        clietname: clientName.text,
                        amountCollected: amountCollected.text,
                      );
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
