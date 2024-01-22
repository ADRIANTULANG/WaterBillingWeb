// import 'dart:math';

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/other_charges_model.dart';

class OtherChargesController extends GetxController {
  RxList<OtherCharges> otherChargesList = <OtherCharges>[].obs;
  createCharges(
      {required String accountnumber,
      required String type,
      required String amount}) async {
    try {
      await FirebaseFirestore.instance.collection('othercharges').add({
        "accountnumber": accountnumber,
        "chargetype": type,
        "amount": amount,
        "datecreated": Timestamp.now(),
        "status": "Unpaid"
      });
      getCharges();
      Get.back();
      Get.snackbar("Message", "Successfully added",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (_) {}
  }

  getCharges() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('othercharges')
          .orderBy('datecreated', descending: true)
          .get();
      var employees = res.docs;
      if (employees.isNotEmpty) {
        List data = [];
        for (var i = 0; i < employees.length; i++) {
          Map mapdata = employees[i].data();
          mapdata['id'] = employees[i].id;
          mapdata['datecreated'] = mapdata['datecreated'].toDate().toString();
          data.add(mapdata);
        }
        otherChargesList.assignAll(otherChargesFromJson(jsonEncode(data)));
      }
    } catch (_) {}
  }

  updateToPaidOrUnpaid({required String docid, required String status}) async {
    try {
      await FirebaseFirestore.instance
          .collection('othercharges')
          .doc(docid)
          .update({"status": status});
      Get.snackbar("Message", "Charges $status",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      getCharges();
    } catch (_) {}
  }

  deleteData({required String docid}) async {
    try {
      await FirebaseFirestore.instance
          .collection('othercharges')
          .doc(docid)
          .delete();
      getCharges();
      Get.back();
      Get.snackbar("Message", "Successfully deleted",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (_) {}
  }

  editCharges(
      {required String docid,
      required String amount,
      required String type,
      required String accountnumber}) async {
    try {
      await FirebaseFirestore.instance
          .collection('othercharges')
          .doc(docid)
          .update({
        "accountnumber": accountnumber,
        "amount": amount,
        "chargetype": type,
      });
      getCharges();
      Get.back();
      Get.snackbar("Message", "Successfully edited",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (_) {}
  }

  @override
  void onInit() {
    // getCharges();
    super.onInit();
  }
}
