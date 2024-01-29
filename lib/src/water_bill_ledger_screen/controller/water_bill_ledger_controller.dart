import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:waterbilling/services/notification_services.dart';
import 'package:waterbilling/src/payment_screen/controller/payment_controller.dart';
import '../../../models/waterbill_model.dart';
import '../alertdialog/water_bill_ledger_alertdialog.dart';

class WaterBillLedgerController extends GetxController {
  // LIST
  RxList<WaterBilling> waterBillList = <WaterBilling>[].obs;
  RxList<WaterBilling> waterBillMasterList = <WaterBilling>[].obs;

  // BOOLEANS
  RxBool isWaterBillError = false.obs;
  // STRING

  getWaterBills() async {
    try {
      var res = await FirebaseFirestore.instance.collection('waterbill').get();
      var waterbills = res.docs;
      List data = [];
      if (waterbills.isNotEmpty) {
        for (var i = 0; i < waterbills.length; i++) {
          Map datamap = waterbills[i].data();
          datamap['id'] = waterbills[i].id;
          if ((datamap['dueDate'].toDate() as DateTime)
              .isBefore(DateTime.now())) {
            datamap['isDue'] = true;
            if (datamap['amount'] > 0) {
              datamap['isDue'] = true;
            } else {
              datamap['isDue'] = false;
            }
          } else {
            datamap['isDue'] = false;
            if (datamap['amount'] > 0) {
              datamap['isDue'] = true;
            } else {
              datamap['isDue'] = false;
            }
          }
          datamap['dueDate'] = datamap['dueDate'].toDate().toString();
          datamap['billingDate'] = datamap['billingDate'].toDate().toString();
          datamap['billingDateTimeStamp'] =
              datamap['billingDateTimeStamp'].toDate().toString();
          data.add(datamap);
        }
        waterBillList.assignAll(waterBillingFromJson(jsonEncode(data)));
        waterBillMasterList.assignAll(waterBillingFromJson(jsonEncode(data)));
      }
    } catch (_) {
      debugPrint("ERROR FUNCTION(getWaterBills) $_");
      isWaterBillError.value = true;
    }
  }

  readExcelFilePaymentCollection() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
      allowMultiple: false,
    );
    if (result != null) {
      WaterBillLedgerAlertDialog.showLoadingDialog();
      WriteBatch batch = FirebaseFirestore.instance.batch();
      Uint8List? bytes = result.files.single.bytes;
      var excel = Excel.decodeBytes(bytes!);
      List data = [];
      for (var table in excel.tables.keys) {
        // print(table); //sheet Name
        // print(excel.tables[table]!.maxCols);
        // print(excel.tables[table]!.maxRows);
        int count = 0;
        for (var row in excel.tables[table]!.rows) {
          // print("kani === $row");
          if (count > 0) {
            Map datamap = {};
            if (row.length == 4) {
              for (var i = 0; i < row.length; i++) {
                if (i == 0) {
                  datamap['accountNumber'] =
                      row[i]!.value.toString().replaceAll("-", "");
                }
                if (i == 1) {
                  datamap['clientName'] = row[i]!.value.toString();
                }
                if (i == 2) {
                  datamap['amountCollected'] =
                      double.parse(row[i]!.value.toString());
                }
                if (i == 3) {
                  datamap['reference'] = row[i]!.value.toString();
                }
              }

              datamap['dateuploaded'] = Timestamp.now();
              // print("$count $datamap");
              data.add(datamap);
              var res = await FirebaseFirestore.instance
                  .collection('paymentCollection')
                  .where('reference',
                      isEqualTo: datamap['reference'].toString())
                  .get();
              if (res.docs.isEmpty) {
                var newPaymentDocRef = FirebaseFirestore.instance
                    .collection('paymentCollection')
                    .doc();
                batch.set(newPaymentDocRef, {
                  "accountNumber": datamap['accountNumber'],
                  "clientName": datamap['clientName'],
                  "reference": datamap['reference'],
                  "amountCollected": datamap['amountCollected'],
                  "dateuploaded": datamap['dateuploaded'],
                });
                var billres = await FirebaseFirestore.instance
                    .collection('waterbill')
                    .where('accountNumber', isEqualTo: datamap['accountNumber'])
                    .limit(1)
                    .get();
                if (billres.docs.isNotEmpty) {
                  var billdetail = billres.docs[0];
                  var billdocref = FirebaseFirestore.instance
                      .collection('waterbill')
                      .doc(billdetail.id);
                  var newAmount =
                      billdetail['amount'] - datamap['amountCollected'];
                  batch.update(billdocref, {"amount": newAmount});
                }
              }
            }
          }
          count++;
        }
      }
      await batch.commit();
      Get.back();
      getWaterBills();
      if (Get.isRegistered<PaymentController>()) {
        Get.find<PaymentController>().getPayments();
      }
    }
  }

  readExcelFileBilling() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
      allowMultiple: false,
    );

    if (result != null) {
      Uint8List? bytes = result.files.single.bytes;
      var excel = Excel.decodeBytes(bytes!);
      List data = [];
      for (var table in excel.tables.keys) {
        // print(table); //sheet Name
        // print(excel.tables[table]!.maxCols);
        // print(excel.tables[table]!.maxRows);
        int count = 0;
        for (var row in excel.tables[table]!.rows) {
          // print("kani === $row");
          if (count > 0) {
            Map datamap = {};
            if (row.length == 11) {
              for (var i = 0; i < row.length; i++) {
                if (i == 0) {
                  datamap['iDnumber'] =
                      row[i]!.value.toString().replaceAll("-", "").toString();
                }
                if (i == 1) {
                  datamap['accountNumber'] =
                      row[i]!.value.toString().replaceAll("-", "").toString();
                }
                if (i == 2) {
                  datamap['prevReading'] =
                      double.parse(row[i]!.value.toString());
                }
                if (i == 3) {
                  datamap['presentReading'] =
                      double.parse(row[i]!.value.toString());
                }
                if (i == 4) {
                  datamap['usage'] = double.parse(row[i]!.value.toString());
                }
                if (i == 5) {
                  datamap['amount'] = double.parse(row[i]!.value.toString());
                }
                if (i == 6) {
                  datamap['discount'] = double.parse(row[i]!.value.toString());
                }
                if (i == 7) {
                  datamap['billingDate'] = Timestamp.fromDate(
                      DateTime.parse(row[i]!.value.toString()));
                }
                if (i == 8) {
                  datamap['billingDateTimeStamp'] = Timestamp.fromDate(
                      DateTime.parse(row[i]!.value.toString()));
                }
                if (i == 9) {
                  datamap['clientName'] = row[i]!.value.toString();
                }
                if (i == 10) {
                  datamap['dueDate'] = Timestamp.fromDate(
                      DateTime.parse(row[i]!.value.toString()));
                }
              }
              // print("$count $datamap");
              data.add(datamap);
            }
          }
          count++;
        }
      }
      WaterBillLedgerAlertDialog.showLoadingDialog();
      await saveWaterBillLedgers(data: data, collection: 'waterbillLedgers');
      if (waterBillList.isEmpty) {
        await saveWaterBillLedgers(data: data, collection: 'waterbill');
      } else {
        await updateWaterBill(data: data);
      }
      await getWaterBills();
      Get.back();
    } else {
      // User canceled the picker
    }
  }

  saveWaterBillLedgers(
      {required List<dynamic> data, required String collection}) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (var bill in data) {
        var docRef = FirebaseFirestore.instance.collection(collection).doc();
        batch.set(docRef, {
          "iDnumber": bill['iDnumber'],
          "accountNumber": bill['accountNumber'],
          "prevReading": bill['prevReading'],
          "presentReading": bill['presentReading'],
          "usage": bill['usage'],
          "amount": bill['amount'],
          "discount": bill['discount'],
          "billingDate": bill['billingDate'],
          "billingDateTimeStamp": bill['billingDateTimeStamp'],
          "clientName": bill['clientName'],
          "dueDate": bill['dueDate'],
        });
      }
      await batch.commit();
    } catch (_) {
      debugPrint("ERROR FUNCTION(saveWaterBillLedgers) $_");
    }
  }

  updateWaterBill({required List<dynamic> data}) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (var x = 0; x < data.length; x++) {
        bool isExist = false;
        var oldAmount = 0.0;
        var documentRef =
            FirebaseFirestore.instance.collection('waterbill').doc();
        for (var i = 0; i < waterBillList.length; i++) {
          if (data[x]['accountNumber'] == waterBillList[i].accountNumber) {
            isExist = true;
            oldAmount = waterBillList[i].amount;
            documentRef = FirebaseFirestore.instance
                .collection('waterbill')
                .doc(waterBillList[i].id);
          }
        }
        if (isExist) {
          var newBalance =
              (data[x]['amount'] - data[x]['discount']) + oldAmount;
          if (newBalance > 0) {
            newBalance = newBalance + (oldAmount * 0.10);
          }
          batch.update(documentRef, {
            "amount": newBalance,
            "dueDate": data[x]['dueDate'],
            "billingDate": data[x]['billingDate'],
            "billingDateTimeStamp": data[x]['billingDateTimeStamp'],
          });
        } else {
          var newdoc = FirebaseFirestore.instance.collection('waterbill').doc();
          batch.set(newdoc, {
            "iDnumber": data[x]['iDnumber'],
            "accountNumber": data[x]['accountNumber'],
            "amount": data[x]['amount'],
            "discount": data[x]['discount'],
            "billingDate": data[x]['billingDate'],
            "billingDateTimeStamp": data[x]['billingDateTimeStamp'],
            "clientName": data[x]['clientName'],
            "dueDate": data[x]['dueDate'],
            "usage": data[x]['usage'],
            "prevReading": data[x]['prevReading'],
            "presentReading": data[x]['presentReading'],
          });
          var newleddoc =
              FirebaseFirestore.instance.collection('waterbillLedgers').doc();
          batch.set(newleddoc, {
            "iDnumber": data[x]['iDnumber'],
            "accountNumber": data[x]['accountNumber'],
            "amount": data[x]['amount'],
            "discount": data[x]['discount'],
            "billingDate": data[x]['billingDate'],
            "billingDateTimeStamp": data[x]['billingDateTimeStamp'],
            "clientName": data[x]['clientName'],
            "dueDate": data[x]['dueDate'],
            "usage": data[x]['usage'],
            "prevReading": data[x]['prevReading'],
            "presentReading": data[x]['presentReading'],
          });
        }
      }
      await batch.commit();
    } catch (_) {
      debugPrint("ERROR FUNCTION(updateWaterBill) $_");
    }
  }

  searchWaterBill({required String word}) async {
    if (word.isNotEmpty) {
      waterBillList.clear();
      for (var i = 0; i < waterBillMasterList.length; i++) {
        if (waterBillMasterList[i]
                .accountNumber
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            waterBillMasterList[i]
                .clientName
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            waterBillMasterList[i]
                .clientName
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            waterBillMasterList[i]
                .billingDate
                .toString()
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            waterBillMasterList[i]
                .dueDate
                .toString()
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString())) {
          waterBillList.add(waterBillMasterList[i]);
        }
      }
    } else {
      waterBillList.assignAll(waterBillMasterList);
    }
  }

  sendNotif({required String message, required String accountNumber}) async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('users')
          .where("accountnumber", isEqualTo: accountNumber)
          .get();
      if (res.docs.isNotEmpty) {
        String fcmToken = res.docs[0].get('fcmToken');
        if (fcmToken != "") {
          Get.find<NotificationServices>().sendNotification(
              userToken: fcmToken,
              message: message,
              title: "Water Bill Notification");
        }
      }
    } catch (_) {}
  }

  @override
  void onInit() {
    getWaterBills();
    super.onInit();
  }
}
