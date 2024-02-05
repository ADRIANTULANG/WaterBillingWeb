import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waterbilling/models/payments_model.dart';

class PaymentController extends GetxController {
  RxList<Payments> paymentsList = <Payments>[].obs;
  RxList<Payments> paymentsMasterList = <Payments>[].obs;

  RxBool isReferenceHovering = false.obs;
  RxBool isAccountNumberHovering = false.obs;
  RxBool isClientHovering = false.obs;
  RxBool isAmountHovering = false.obs;
  RxBool isDateUploadHovering = false.obs;

  RxBool isReferenceUp = false.obs;
  RxBool isAccountNumbertUp = false.obs;
  RxBool isClientUp = false.obs;
  RxBool isAmountUp = false.obs;
  RxBool isDateUploadUp = false.obs;

  getPayments() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('paymentCollection')
          .orderBy('dateuploaded', descending: true)
          .get();
      var payments = res.docs;

      if (payments.isNotEmpty) {
        List data = [];
        for (var i = 0; i < payments.length; i++) {
          Map mapdata = payments[i].data();
          mapdata['id'] = payments[i].id;
          mapdata['dateuploaded'] =
              payments[i]['dateuploaded'].toDate().toString();
          data.add(mapdata);
        }
        paymentsList.assignAll(paymentsFromJson(jsonEncode(data)));
        paymentsMasterList.assignAll(paymentsFromJson(jsonEncode(data)));
      }
    } catch (_) {}
  }

  searchPayments({required String word}) async {
    if (word.isNotEmpty) {
      paymentsList.clear();
      for (var i = 0; i < paymentsMasterList.length; i++) {
        if (paymentsMasterList[i]
                .accountNumber
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            paymentsMasterList[i]
                .reference
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            paymentsMasterList[i]
                .clientName
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            paymentsMasterList[i]
                .dateuploaded
                .toString()
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString())) {
          paymentsList.add(paymentsMasterList[i]);
        }
      }
    } else {
      paymentsList.assignAll(paymentsMasterList);
    }
  }

  fieldSorter({required String field, required bool isUp}) async {
    if (field == 'Account no') {
      if (isUp) {
        paymentsList.sort((a, b) => a.accountNumber.compareTo(b.accountNumber));
      } else {
        paymentsList.sort((b, a) => a.accountNumber.compareTo(b.accountNumber));
      }
    }
    if (field == 'Client') {
      if (isUp) {
        paymentsList.sort((a, b) => a.clientName.compareTo(b.clientName));
      } else {
        paymentsList.sort((b, a) => a.clientName.compareTo(b.clientName));
      }
    }
    if (field == 'Reference') {
      if (isUp) {
        paymentsList.sort((a, b) => a.reference.compareTo(b.reference));
      } else {
        paymentsList.sort((b, a) => a.reference.compareTo(b.reference));
      }
    }
    if (field == 'Amount Collected') {
      if (isUp) {
        paymentsList
            .sort((a, b) => a.amountCollected.compareTo(b.amountCollected));
      } else {
        paymentsList
            .sort((b, a) => a.amountCollected.compareTo(b.amountCollected));
      }
    }
    if (field == 'Date Uploaded') {
      if (isUp) {
        paymentsList.sort((a, b) => a.dateuploaded.compareTo(b.dateuploaded));
      } else {
        paymentsList.sort((b, a) => a.dateuploaded.compareTo(b.dateuploaded));
      }
    }
  }

  editPayment(
      {required String documentID,
      required String clietname,
      required String amountCollected,
      required String reference}) async {
    try {
      await FirebaseFirestore.instance
          .collection('paymentCollection')
          .doc(documentID)
          .update({
        "reference": reference,
        "clientName": clietname,
        "amountCollected": double.parse(amountCollected),
      });
      Get.back();
      getPayments();
      Get.snackbar("Message", "Payment updated.",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (_) {}
  }

  deletePayment({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('paymentCollection')
          .doc(documentID)
          .delete();
      Get.back();
      getPayments();
      Get.snackbar("Message", "Payment deleted.",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (_) {}
  }

  @override
  void onInit() {
    getPayments();
    super.onInit();
  }
}
