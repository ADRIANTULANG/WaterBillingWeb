import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/payment_screen/controller/payment_controller.dart';

import '../widget/payment_header.dart';
import '../widget/payment_list_view.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});
  static const String id = "payment";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Padding(
      padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payments",
                style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.bold),
              ),

              ElevatedButton(
                onPressed: () {
                  controller.getPayments();
                },
                child: const Icon(Icons.refresh_rounded),
              )
              // Row(
              //   children: [
              //     ElevatedButton(
              //         onPressed: () {
              //           controller.readExcelFileCollection();
              //         },
              //         child: const Text(
              //           "Upload Payment",
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, color: Colors.white),
              //         )),
              //     SizedBox(
              //       width: 1.5.w,
              //     ),
              //     ElevatedButton(
              //         onPressed: () {
              //           controller.readExcelFileBilling();
              //         },
              //         child: const Text(
              //           "Upload Billing",
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, color: Colors.white),
              //         )),
              //   ],
              // )
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
                  const PaymentHeaderView(),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Expanded(
                    child: SizedBox(
                      child: PaymentListView(),
                    ),
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
