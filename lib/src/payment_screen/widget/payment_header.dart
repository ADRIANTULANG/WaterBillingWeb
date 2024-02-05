import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/payment_screen/controller/payment_controller.dart';

class PaymentHeaderView extends GetView<PaymentController> {
  const PaymentHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(left: 1.w, right: 1.w),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: MouseRegion(
                  onHover: (value) {
                    controller.isReferenceHovering.value = true;
                  },
                  onExit: (value) {
                    controller.isReferenceHovering.value = false;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Reference no.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.isReferenceUp.value) {
                            controller.isReferenceUp.value = false;
                          } else {
                            controller.isReferenceUp.value = true;
                          }
                          controller.fieldSorter(
                              field: "Reference",
                              isUp: controller.isReferenceUp.value);
                        },
                        child: Obx(
                          () => controller.isReferenceHovering.value
                              ? controller.isReferenceUp.value
                                  ? Icon(
                                      Icons.arrow_upward,
                                      size: 4.sp,
                                    )
                                  : Icon(
                                      Icons.arrow_downward,
                                      size: 4.sp,
                                    )
                              : const SizedBox(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: MouseRegion(
                  onHover: (value) {
                    controller.isAccountNumberHovering.value = true;
                  },
                  onExit: (value) {
                    controller.isAccountNumberHovering.value = false;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Account no.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.isAccountNumbertUp.value) {
                            controller.isAccountNumbertUp.value = false;
                          } else {
                            controller.isAccountNumbertUp.value = true;
                          }
                          controller.fieldSorter(
                              field: "Account no",
                              isUp: controller.isAccountNumbertUp.value);
                        },
                        child: Obx(
                          () => controller.isAccountNumberHovering.value
                              ? controller.isAccountNumbertUp.value
                                  ? Icon(
                                      Icons.arrow_upward,
                                      size: 4.sp,
                                    )
                                  : Icon(
                                      Icons.arrow_downward,
                                      size: 4.sp,
                                    )
                              : const SizedBox(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: MouseRegion(
                  onHover: (value) {
                    controller.isClientHovering.value = true;
                  },
                  onExit: (value) {
                    controller.isClientHovering.value = false;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Client.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.isClientUp.value) {
                            controller.isClientUp.value = false;
                          } else {
                            controller.isClientUp.value = true;
                          }
                          controller.fieldSorter(
                              field: "Client",
                              isUp: controller.isClientUp.value);
                        },
                        child: Obx(
                          () => controller.isClientHovering.value
                              ? controller.isClientUp.value
                                  ? Icon(
                                      Icons.arrow_upward,
                                      size: 4.sp,
                                    )
                                  : Icon(
                                      Icons.arrow_downward,
                                      size: 4.sp,
                                    )
                              : const SizedBox(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: MouseRegion(
                  onHover: (value) {
                    controller.isAmountHovering.value = true;
                  },
                  onExit: (value) {
                    controller.isAmountHovering.value = false;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Amount Collected.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.isAmountUp.value) {
                            controller.isAmountUp.value = false;
                          } else {
                            controller.isAmountUp.value = true;
                          }
                          controller.fieldSorter(
                              field: "Amount Collected",
                              isUp: controller.isAmountUp.value);
                        },
                        child: Obx(
                          () => controller.isAmountHovering.value
                              ? controller.isAmountUp.value
                                  ? Icon(
                                      Icons.arrow_upward,
                                      size: 4.sp,
                                    )
                                  : Icon(
                                      Icons.arrow_downward,
                                      size: 4.sp,
                                    )
                              : const SizedBox(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: MouseRegion(
                  onHover: (value) {
                    controller.isDateUploadHovering.value = true;
                  },
                  onExit: (value) {
                    controller.isDateUploadHovering.value = false;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Date.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.isDateUploadUp.value) {
                            controller.isDateUploadUp.value = false;
                          } else {
                            controller.isDateUploadUp.value = true;
                          }
                          controller.fieldSorter(
                              field: "Date Uploaded",
                              isUp: controller.isDateUploadUp.value);
                        },
                        child: Obx(
                          () => controller.isDateUploadHovering.value
                              ? controller.isDateUploadUp.value
                                  ? Icon(
                                      Icons.arrow_upward,
                                      size: 4.sp,
                                    )
                                  : Icon(
                                      Icons.arrow_downward,
                                      size: 4.sp,
                                    )
                              : const SizedBox(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  "Actions",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
