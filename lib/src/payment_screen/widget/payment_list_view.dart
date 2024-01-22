import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/payment_screen/controller/payment_controller.dart';
import 'package:intl/intl.dart';

class PaymentListView extends GetView<PaymentController> {
  const PaymentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>  controller.paymentsList.isEmpty
          ? const Center(
              child: Text("No available data."),
            )
          : ListView.builder(
        itemCount: controller.paymentsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.only(left: 1.w, right: 1.w),
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(
                                text:
                                    controller.paymentsList[index].reference));
                            Get.snackbar("Message", "Text copied to clip board",
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP);
                          },
                          child: Text(
                            controller.paymentsList[index].reference,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(
                                text: controller
                                    .paymentsList[index].accountNumber));
                            Get.snackbar("Message", "Text copied to clip board",
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP);
                          },
                          child: Text(
                            controller.paymentsList[index].accountNumber,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(
                                text:
                                    controller.paymentsList[index].clientName));
                            Get.snackbar("Message", "Text copied to clip board",
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP);
                          },
                          child: Text(
                            controller.paymentsList[index].clientName,
                            // controller.paymentsList[index].bil.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          controller.paymentsList[index].amountCollected
                              .toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          DateFormat.yMMMd().format(
                              controller.paymentsList[index].dateuploaded),
                          // controller.paymentsList[index].bil.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
