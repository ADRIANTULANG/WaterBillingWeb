import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waterbilling/models/employees_model.dart';
import 'package:waterbilling/models/service_request_model.dart';
import 'package:waterbilling/services/notification_services.dart';

class ServiceRequestController extends GetxController {
  RxList<ServiceRequest> serviceRequestList = <ServiceRequest>[].obs;
  RxList<ServiceRequest> serviceRequestMasterList = <ServiceRequest>[].obs;

  RxList<Employees> employeeesList = <Employees>[].obs;
  Rx<Employees> selectedEmployee = Employees(
          contactno: "",
          password: "",
          type: "",
          datecreated: DateTime.now(),
          firstname: "",
          lastname: "",
          username: "",
          id: "None")
      .obs;

  getServiceRequest() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('serviceRequest')
          .orderBy('datecreated', descending: true)
          .get();
      var request = res.docs;
      List userslist = [];
      for (var i = 0; i < request.length; i++) {
        Map mapdata = request[i].data();
        mapdata['id'] = request[i].id;
        if (mapdata.containsKey('statusstring') == false) {
          mapdata['statusstring'] = '';
        }
        mapdata['datecreated'] = request[i]['datecreated'].toDate().toString();
        userslist.add(mapdata);
      }
      serviceRequestList
          .assignAll(serviceRequestFromJson(jsonEncode(userslist)));
      serviceRequestMasterList
          .assignAll(serviceRequestFromJson(jsonEncode(userslist)));
    } catch (_) {
      debugPrint("ERROR FUNCTION(getServiceRequest) $_");
    }
  }

  getEmployee() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('employees')
          .orderBy('datecreated', descending: true)
          .get();
      var employee = res.docs;
      List data = [];
      for (var i = 0; i < employee.length; i++) {
        Map mapdata = employee[i].data();
        mapdata['id'] = employee[i].id;
        mapdata['datecreated'] = employee[i]['datecreated'].toDate().toString();
        data.add(mapdata);
      }
      employeeesList.assignAll(employeesFromJson(jsonEncode(data)));
      employeeesList.insert(0, selectedEmployee.value);
    } catch (_) {
      debugPrint("ERROR FUNCTION(getEmployee) $_");
    }
  }

  updateStatusAndAssign(
      {required String employeeID,
      required String employeeName,
      required String requestID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('serviceRequest')
          .doc(requestID)
          .update({
        "employeeName": employeeName,
        "employeeid": employeeID,
        "status": true,
        "statusstring": "Accepted"
      });
      Get.back();
      getServiceRequest();
      Get.snackbar("Message", "Successfully assigned employee to the request",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (_) {}
  }

  updateRejectStatus({required String requestID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('serviceRequest')
          .doc(requestID)
          .update({"status": false, "statusstring": "Rejected"});
      Get.back();
      getServiceRequest();
      Get.snackbar("Message", "Request rejected",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (_) {}
  }

  searchServiceRequest({required String word}) async {
    if (word.isNotEmpty) {
      serviceRequestList.clear();
      for (var i = 0; i < serviceRequestMasterList.length; i++) {
        if (serviceRequestMasterList[i]
                .accountNumber
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            serviceRequestMasterList[i]
                .address
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            serviceRequestMasterList[i]
                .firstname
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            serviceRequestMasterList[i]
                .lastname
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            serviceRequestMasterList[i]
                .serviceType
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            serviceRequestMasterList[i]
                .employeeName
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString())) {
          serviceRequestList.add(serviceRequestMasterList[i]);
        }
      }
    } else {
      serviceRequestList.assignAll(serviceRequestMasterList);
    }
  }

  sendNotif(
      {required String clientmessage,
      required String employeemessage,
      required String accountNumber,
      required bool status,
      required String employeeID}) async {
    try {
      var user = await FirebaseFirestore.instance
          .collection('users')
          .where("accountnumber", isEqualTo: accountNumber)
          .get();
      if (user.docs.isNotEmpty) {
        String fcmToken = user.docs[0].get('fcmToken');
        if (fcmToken != "") {
          Get.find<NotificationServices>().sendNotification(
              userToken: fcmToken,
              message: clientmessage,
              title: "Service Request Notification");
        }
      }
      if (status == true) {
        var employee = await FirebaseFirestore.instance
            .collection('employees')
            .doc(employeeID)
            .get();
        if (employee.exists) {
          String fcmToken = employee.get('fcmToken');
          if (fcmToken != "") {
            Get.find<NotificationServices>().sendNotification(
                userToken: fcmToken,
                message: employeemessage,
                title: "Service Request Notification");
          }
        }
      }
    } catch (_) {}
  }

  @override
  void onInit() {
    getServiceRequest();
    getEmployee();
    super.onInit();
  }
}
