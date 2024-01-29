import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/dashboard_screen/controller/dashboard_controller.dart';
import 'package:waterbilling/src/dashboard_screen/view/dashboard_tab_view.dart';
import 'package:waterbilling/src/employee_screen/controller/employee_controller.dart';
import 'package:waterbilling/src/employee_screen/view/employee_view.dart';
import 'package:waterbilling/src/login_screen/view/login_view.dart';
import 'package:waterbilling/src/other_charges_screen/view/other_charges_view.dart';
import 'package:waterbilling/src/payment_screen/controller/payment_controller.dart';
import 'package:waterbilling/src/payment_screen/view/payment_view.dart';
import 'package:waterbilling/src/services_request_screen/controller/service_request_controller.dart';
import 'package:waterbilling/src/services_request_screen/view/service_request_view.dart';
import 'package:waterbilling/src/water_bill_ledger_screen/controller/water_bill_ledger_controller.dart';
import 'package:waterbilling/src/water_bill_ledger_screen/view/water_bill_ledger_view.dart';
import '../../../services/getstorage_services.dart';
import '../../concessionaire_screen/controller/concessionaire_controller.dart';
import '../../concessionaire_screen/view/concessionaire_view.dart';

class DashboardView extends StatefulWidget {
  static const String id = "dashboard";

  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final controller = Get.put(DashboardController());

  @override
  void initState() {
    Get.put(ConcessionaireController());
    if (Get.find<StorageServices>().storage.read("screen") != null) {
      controller.selectedScreen.value =
          Get.find<StorageServices>().storage.read("screen");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const SizedBox(
            child: Icon(Icons.add),
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.lightGreen[900],
          title: Row(
            children: [
              SizedBox(
                child: Text(
                  "     ",
                  style: TextStyle(
                    fontSize: 5.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Obx(
                () => controller.selectedScreen.value != "dashboard_tab"
                    ? Container(
                        width: 35.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: TextField(
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          onChanged: (value) {
                            if (controller.selectedScreen.value ==
                                ServiceRequestView.id) {
                              Get.find<ServiceRequestController>()
                                  .searchServiceRequest(word: value);
                            }
                            if (controller.selectedScreen.value ==
                                PaymentView.id) {
                              Get.find<PaymentController>()
                                  .searchPayments(word: value);
                            }
                            if (controller.selectedScreen.value ==
                                EmployeeView.id) {
                              Get.find<EmployeeController>()
                                  .searchEmployees(word: value);
                            }
                            if (controller.selectedScreen.value ==
                                WaterBillLedgerView.id) {
                              Get.find<WaterBillLedgerController>()
                                  .searchWaterBill(word: value);
                            }
                            if (controller.selectedScreen.value ==
                                ConcessionaireView.id) {
                              Get.find<ConcessionaireController>()
                                  .searchConcessionaire(word: value);
                            }
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 1.w, top: 2.h)),
                        ),
                      )
                    : const SizedBox(),
              ),
              SizedBox(
                width: .5.w,
              ),
              Obx(() => controller.selectedScreen.value != "dashboard_tab"
                  ? Container(
                      height: 5.h,
                      width: 5.w,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        Icons.search,
                        color: Colors.lightGreen[900],
                      ),
                    )
                  : const SizedBox())
            ],
          ),
          actions: [
            Obx(() => controller.selectedScreen.value == "dashboard_tab"
                ? Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            controller.selectedChart.value = "column";
                          },
                          icon: const Icon(Icons.bar_chart)),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      IconButton(
                          onPressed: () {
                            controller.selectedChart.value = "line";
                          },
                          icon: const Icon(Icons.line_axis)),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      IconButton(
                          onPressed: () {
                            controller.selectedChart.value = "area";
                          },
                          icon: const Icon(Icons.area_chart)),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      IconButton(
                          onPressed: () {
                            controller.selectedChart.value = "bubble";
                          },
                          icon: const Icon(Icons.bubble_chart)),
                      SizedBox(
                        width: 1.5.w,
                      ),
                      IconButton(
                          onPressed: () {
                            controller.selectedChart.value = "bar";
                          },
                          icon: const Icon(Icons.table_rows)),
                      SizedBox(
                        width: 3.w,
                      ),
                    ],
                  )
                : const SizedBox()),
            Align(
                alignment: Alignment.center,
                child: Text(Get.find<StorageServices>()
                    .storage
                    .read("email")
                    .toString())),
            SizedBox(
              width: .5.w,
            ),
            // Container(
            //   height: 2.5.h,
            //   width: 2.5.w,
            //   decoration: const BoxDecoration(
            //       shape: BoxShape.circle, color: Colors.white),
            // ),
            SizedBox(
              width: 1.w,
            ),
          ],
        ),
        sideBar: SideBar(
          iconColor: Colors.lightGreen[900],
          backgroundColor: Colors.white,
          activeBackgroundColor: Colors.lightGreen,
          activeIconColor: Colors.lightGreen[900],
          textStyle: const TextStyle(color: Colors.black),
          items: const [
            AdminMenuItem(
              title: 'Dashboard',
              route: DashboardTabView.id,
              icon: Icons.dashboard,
            ),
            AdminMenuItem(
              title: 'Concessionaire',
              route: ConcessionaireView.id,
              icon: Icons.person,
            ),
            AdminMenuItem(
              title: 'Water Bill',
              route: WaterBillLedgerView.id,
              icon: Icons.water,
            ),
            // AdminMenuItem(
            //   title: 'Other Charges',
            //   route: OtherChargesView.id,
            //   icon: Icons.receipt,
            // ),
            AdminMenuItem(
              title: 'Service Request',
              route: ServiceRequestView.id,
              icon: Icons.request_page_rounded,
            ),
            AdminMenuItem(
              title: 'Payments',
              route: PaymentView.id,
              icon: Icons.receipt_long_outlined,
            ),
            AdminMenuItem(
              title: 'Employees',
              route: EmployeeView.id,
              icon: Icons.group,
            ),
          ],
          selectedRoute: DashboardView.id,
          onSelected: (item) {
            controller.currentScreen(item: item);
          },
          header: Container(
            color: Colors.white,
            height: 20.h,
            child: Padding(
              padding:
                  EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h, bottom: 2.h),
              child: SizedBox(
                width: 100.w,
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
          ),
          footer: InkWell(
            onTap: () {
              Get.find<StorageServices>().removeStorageCredentials();
              Get.offAllNamed(LoginView.id);
            },
            child: Container(
              height: 7.h,
              width: double.infinity,
              color: Colors.lightGreen[900],
              child: const Center(
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Obx(() => controller.selectedScreen.value == DashboardTabView.id
            ? const DashboardTabView()
            : controller.selectedScreen.value == ConcessionaireView.id
                ? const ConcessionaireView()
                : controller.selectedScreen.value == WaterBillLedgerView.id
                    ? const WaterBillLedgerView()
                    : controller.selectedScreen.value == OtherChargesView.id
                        ? const OtherChargesView()
                        : controller.selectedScreen.value ==
                                ServiceRequestView.id
                            ? const ServiceRequestView()
                            : controller.selectedScreen.value == EmployeeView.id
                                ? const EmployeeView()
                                : const PaymentView()));
  }
}
