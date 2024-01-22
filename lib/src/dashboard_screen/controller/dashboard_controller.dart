import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';
import 'package:waterbilling/models/waterbill_model.dart';
import 'package:waterbilling/src/concessionaire_screen/view/concessionaire_view.dart';
import 'package:waterbilling/src/dashboard_screen/view/dashboard_tab_view.dart';
import 'package:waterbilling/src/employee_screen/controller/employee_controller.dart';
import 'package:waterbilling/src/employee_screen/view/employee_view.dart';
import 'package:waterbilling/src/other_charges_screen/view/other_charges_view.dart';
import 'package:waterbilling/src/payment_screen/view/payment_view.dart';
import 'package:waterbilling/src/services_request_screen/controller/service_request_controller.dart';
import 'package:waterbilling/src/services_request_screen/view/service_request_view.dart';
import 'package:waterbilling/src/water_bill_ledger_screen/controller/water_bill_ledger_controller.dart';
import 'package:waterbilling/src/water_bill_ledger_screen/view/water_bill_ledger_view.dart';

import '../../../models/activities_model.dart';
import '../../../models/chart_model.dart';
import '../../../services/getstorage_services.dart';
import '../../concessionaire_screen/controller/concessionaire_controller.dart';
import '../../payment_screen/controller/payment_controller.dart';

class DashboardController extends GetxController {
  // STRINGS
  RxString selectedScreen = DashboardTabView.id.obs;
  RxString selectedChart = "column".obs;
  RxString selectedDataToCompare = "amount".obs;
  // BOLEAN
  //DOUBLE
  RxDouble max = 10000.0.obs;
  RxDouble interval = 1000.0.obs;
  //INT
  // RxInt selectedYear = DateTime.now().year.obs;
  RxInt selectedYear = 2023.obs;

  // LIST
  RxList<WaterBilling> waterBillList = <WaterBilling>[].obs;
  RxList<Activities> activitiesList = <Activities>[].obs;
  RxList<ChartData> chartdata = <ChartData>[
    ChartData('JAN', 10),
    ChartData('FEB', 10),
    ChartData('MAR', 10),
    ChartData('APR', 10),
    ChartData('MAY', 10),
    ChartData('JUN', 10),
    ChartData('JUL', 10),
    ChartData('AUG', 10),
    ChartData('SEP', 10),
    ChartData('OCT', 10),
    ChartData('NOV', 10),
    ChartData('DEC', 10),
  ].obs;

  getWaterBills() async {
    try {
      var res =
          await FirebaseFirestore.instance.collection('waterbillLedgers').get();
      var waterbills = res.docs;
      List data = [];
      if (waterbills.isNotEmpty) {
        for (var i = 0; i < waterbills.length; i++) {
          Map datamap = waterbills[i].data();
          datamap['id'] = waterbills[i].id;
          if ((datamap['dueDate'].toDate() as DateTime)
              .isBefore(DateTime.now())) {
            datamap['isDue'] = true;
          } else {
            datamap['isDue'] = false;
          }
          datamap['dueDate'] = datamap['dueDate'].toDate().toString();
          datamap['billingDate'] = datamap['billingDate'].toDate().toString();
          datamap['billingDateTimeStamp'] =
              datamap['billingDateTimeStamp'].toDate().toString();
          data.add(datamap);
        }
        waterBillList.assignAll(waterBillingFromJson(jsonEncode(data)));
        await chartdataSorter();
      }
    } catch (_) {
      debugPrint("ERROR FUNCTION(getWaterBills) $_");
    }
  }

  chartdataSorter() {
    double jan = 0.0;
    double feb = 0.0;
    double mar = 0.0;
    double apr = 0.0;
    double may = 0.0;
    double jun = 0.0;
    double jul = 0.0;
    double aug = 0.0;
    double sep = 0.0;
    double oct = 0.0;
    double nov = 0.0;
    double dec = 0.0;
    double total = 0.0;

    for (var i = 0; i < waterBillList.length; i++) {
      if (selectedYear.value == waterBillList[i].billingDate.year) {
        if (selectedDataToCompare.value == "amount") {
          total = total + (waterBillList[i].amount - waterBillList[i].discount);
        } else {
          total = total + waterBillList[i].usage;
        }

        switch (waterBillList[i].billingDate.month) {
          case 1:
            if (selectedDataToCompare.value == "amount") {
              jan = jan + (waterBillList[i].amount - waterBillList[i].discount);
            } else {
              jan = jan + waterBillList[i].usage;
            }
            break;
          case 2:
            if (selectedDataToCompare.value == "amount") {
              feb = feb + (waterBillList[i].amount - waterBillList[i].discount);
            } else {
              feb = feb + waterBillList[i].usage;
            }
            break;
          case 3:
            if (selectedDataToCompare.value == "amount") {
              mar = mar + (waterBillList[i].amount - waterBillList[i].discount);
            } else {
              mar = mar + waterBillList[i].usage;
            }
            break;
          case 4:
            if (selectedDataToCompare.value == "amount") {
              apr = apr + (waterBillList[i].amount - waterBillList[i].discount);
            } else {
              apr = apr + waterBillList[i].usage;
            }
            break;
          case 5:
            if (selectedDataToCompare.value == "amount") {
              may = may + (waterBillList[i].amount - waterBillList[i].discount);
            } else {
              may = may + waterBillList[i].usage;
            }
            break;
          case 6:
            if (selectedDataToCompare.value == "amount") {
              jun = jun + (waterBillList[i].amount - waterBillList[i].discount);
            } else {
              jun = jun + waterBillList[i].usage;
            }
            break;
          case 7:
            if (selectedDataToCompare.value == "amount") {
              jul = jul + (waterBillList[i].amount - waterBillList[i].discount);
            } else {
              jul = jul + waterBillList[i].usage;
            }
            break;
          case 8:
            if (selectedDataToCompare.value == "amount") {
              aug = aug + (waterBillList[i].amount - waterBillList[i].discount);
            } else {
              aug = aug + waterBillList[i].usage;
            }
            break;
          case 9:
            if (selectedDataToCompare.value == "amount") {
              sep = sep + (waterBillList[i].amount - waterBillList[i].discount);
            } else {
              sep = sep + waterBillList[i].usage;
            }
            break;
          case 10:
            if (selectedDataToCompare.value == "amount") {
              oct = oct + (waterBillList[i].amount - waterBillList[i].discount);
            } else {
              oct = oct + waterBillList[i].usage;
            }
            break;
          case 11:
            if (selectedDataToCompare.value == "amount") {
              nov = nov + (waterBillList[i].amount - waterBillList[i].discount);
            } else {
              nov = nov + waterBillList[i].usage;
            }
            break;
          case 12:
            if (selectedDataToCompare.value == "amount") {
              dec = dec + (waterBillList[i].amount - waterBillList[i].discount);
            } else {
              dec = dec + waterBillList[i].usage;
            }
            break;
          default:
            // Code to execute if option doesn't match any case
            break;
        }
      }
    }
    chartdata.clear();

    var datachart = [
      ChartData('JAN', jan),
      ChartData('FEB', feb),
      ChartData('MAR', mar),
      ChartData('APR', apr),
      ChartData('MAY', may),
      ChartData('JUN', jun),
      ChartData('JUL', jul),
      ChartData('AUG', aug),
      ChartData('SEP', sep),
      ChartData('OCT', oct),
      ChartData('NOV', nov),
      ChartData('DEC', dec),
    ];

    chartdata.assignAll(datachart);
    if (total > 0) {
      max.value = total;

      double numberOfZeros = double.parse((max.value / 5).toStringAsFixed(0));
      int zerosLength = numberOfZeros.toStringAsFixed(0).toString().length - 1;
      String roundingFactorToFormat = "";

      for (int i = 0; i < zerosLength; i++) {
        roundingFactorToFormat += '0';
      }
      if (selectedDataToCompare.value == "amount") {
        roundingFactorToFormat = "2$roundingFactorToFormat";
      } else {
        roundingFactorToFormat = "1$roundingFactorToFormat";
      }
      interval.value = double.parse(roundingFactorToFormat);
    }
  }

  currentScreen({required AdminMenuItem item}) async {
    if (item.route == DashboardTabView.id) {
      selectedScreen.value = DashboardTabView.id;
    }
    if (item.route == ConcessionaireView.id) {
      selectedScreen.value = ConcessionaireView.id;
    }
    if (item.route == WaterBillLedgerView.id) {
      selectedScreen.value = WaterBillLedgerView.id;
    }
    if (item.route == OtherChargesView.id) {
      selectedScreen.value = OtherChargesView.id;
    }
    if (item.route == ServiceRequestView.id) {
      selectedScreen.value = ServiceRequestView.id;
    }
    if (item.route == EmployeeView.id) {
      selectedScreen.value = EmployeeView.id;
    }
    if (item.route == PaymentView.id) {
      selectedScreen.value = PaymentView.id;
    }
    Get.find<StorageServices>().saveRoute(screen: selectedScreen.value);
  }

  getActivities() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('activities')
          .orderBy('datecreated', descending: true)
          .get();
      var activities = res.docs;
      if (activities.isNotEmpty) {
        List data = [];
        for (var i = 0; i < activities.length; i++) {
          Map mapdata = activities[i].data();
          mapdata['id'] = activities[i].id;
          mapdata['datecreated'] = mapdata['datecreated'].toDate().toString();
          data.add(mapdata);
        }
        activitiesList.assignAll(activitiesFromJson(jsonEncode(data)));
      }
    } catch (_) {}
  }

  @override
  void onInit() {
    getWaterBills();
    getActivities();
    Get.put(ConcessionaireController());
    Get.put(WaterBillLedgerController());
    Get.put(PaymentController());
    Get.put(EmployeeController());
    // Get.put(OtherChargesController());
    Get.put(ServiceRequestController());

    super.onInit();
  }
}
