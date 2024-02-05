import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/water_bill_ledger_screen/controller/water_bill_ledger_controller.dart';

class WaterBillLedgerHeaderView extends GetView<WaterBillLedgerController> {
  const WaterBillLedgerHeaderView({super.key});

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
                    controller.isAccountNumbertHovering.value = true;
                  },
                  onExit: (value) {
                    controller.isAccountNumbertHovering.value = false;
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
                          () => controller.isAccountNumbertHovering.value
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
                        "Client",
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
                    controller.isBalanceHovering.value = true;
                  },
                  onExit: (value) {
                    controller.isBalanceHovering.value = false;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Balance",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.isBalanceUp.value) {
                            controller.isBalanceUp.value = false;
                          } else {
                            controller.isBalanceUp.value = true;
                          }
                          controller.fieldSorter(
                              field: "Balance",
                              isUp: controller.isBalanceUp.value);
                        },
                        child: Obx(
                          () => controller.isBalanceHovering.value
                              ? controller.isBalanceUp.value
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
                    controller.isBillingDateHovering.value = true;
                  },
                  onExit: (value) {
                    controller.isBillingDateHovering.value = false;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Billing Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.isBillingDateUp.value) {
                            controller.isBillingDateUp.value = false;
                          } else {
                            controller.isBillingDateUp.value = true;
                          }
                          controller.fieldSorter(
                              field: "Billing Date",
                              isUp: controller.isBillingDateUp.value);
                        },
                        child: Obx(
                          () => controller.isBillingDateHovering.value
                              ? controller.isBillingDateUp.value
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
                    controller.isDueDateHovering.value = true;
                  },
                  onExit: (value) {
                    controller.isDueDateHovering.value = false;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Due Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.isDueDateUp.value) {
                            controller.isDueDateUp.value = false;
                          } else {
                            controller.isDueDateUp.value = true;
                          }
                          controller.fieldSorter(
                              field: "Due Date",
                              isUp: controller.isDueDateUp.value);
                        },
                        child: Obx(
                          () => controller.isDueDateHovering.value
                              ? controller.isDueDateUp.value
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
                  "      ",
                  style: TextStyle(fontWeight: FontWeight.bold),
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
            const Expanded(
              child: Center(
                child: Text(
                  "      ",
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
