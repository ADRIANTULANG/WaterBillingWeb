import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/employees_model.dart';

class EmployeeController extends GetxController {
  RxList<Employees> employeeesList = <Employees>[].obs;
  RxList<Employees> employeeesMaterList = <Employees>[].obs;

  addEmployee({
    required String firstname,
    required String lastname,
    required String contactno,
    required String type,
    required String username,
    required String password,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('employees').add({
        "firstname": firstname,
        "lastname": lastname,
        "contactno": contactno,
        "username": username,
        "password": password,
        "type": type,
        "datecreated": Timestamp.now(),
        "fcmToken": ""
      });
      getEmployees();
      Get.back();
      Get.snackbar("Message", "Successfully added",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (_) {}
  }

  getEmployees() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('employees')
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
        employeeesList.assignAll(employeesFromJson(jsonEncode(data)));
        employeeesMaterList.assignAll(employeesFromJson(jsonEncode(data)));
      }
    } catch (_) {}
  }

  editCharges({
    required String docid,
    required String fname,
    required String lname,
    required String username,
    required String password,
    required String type,
    required String contactno,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('employees')
          .doc(docid)
          .update({
        "type": type,
        "firstname": fname,
        "lastname": lname,
        "contactno": contactno,
        "username": username,
        "password": password,
      });
      getEmployees();
      Get.back();
      Get.snackbar("Message", "Successfully edited",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (_) {}
  }

  deleteData({required String docid}) async {
    try {
      await FirebaseFirestore.instance
          .collection('employees')
          .doc(docid)
          .delete();
      getEmployees();
      Get.back();
      Get.snackbar("Message", "Successfully deleted",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (_) {}
  }

  searchEmployees({required String word}) async {
    if (word.isNotEmpty) {
      employeeesList.clear();
      for (var i = 0; i < employeeesMaterList.length; i++) {
        if (employeeesMaterList[i]
                .firstname
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            employeeesMaterList[i]
                .lastname
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            employeeesMaterList[i]
                .type
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            employeeesMaterList[i]
                .contactno
                .toString()
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString())) {
          employeeesList.add(employeeesMaterList[i]);
        }
      }
    } else {
      employeeesList.assignAll(employeeesMaterList);
    }
  }

  @override
  void onInit() {
    getEmployees();
    super.onInit();
  }
}
