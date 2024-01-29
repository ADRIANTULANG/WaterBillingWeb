import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waterbilling/services/notification_services.dart';
import '../../../models/users_model.dart';

class ConcessionaireController extends GetxController {
  RxList<Users> usersList = <Users>[].obs;
  RxList<Users> usersMasterList = <Users>[].obs;

  getConcessionaires() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('datecreated', descending: true)
          .get();
      var users = res.docs;
      List userslist = [];
      for (var i = 0; i < users.length; i++) {
        Map mapdata = users[i].data();
        mapdata['id'] = users[i].id;
        if (mapdata.containsKey('status') == false) {
          mapdata['status'] = '';
        }
        mapdata['datecreated'] = users[i]['datecreated'].toDate().toString();
        userslist.add(mapdata);
      }
      usersList.assignAll(usersFromJson(jsonEncode(userslist)));
      usersMasterList.assignAll(usersFromJson(jsonEncode(userslist)));
    } catch (_) {
      debugPrint("ERROR FUNCTION(getConcessionaireView) $_");
    }
  }

  acceptRejectUser({required bool action, required String docid}) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(docid).update(
          {"isAccepted": action, 'status': action ? "Accepted" : "Rejected"});
      getConcessionaires();
    } catch (_) {
      debugPrint("ERROR FUNCTION(acceptRejectUser) $_");
    }
  }

  Future<void> downloadUrl({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch url');
    }
  }

  searchConcessionaire({required String word}) async {
    if (word.isNotEmpty) {
      usersList.clear();
      for (var i = 0; i < usersMasterList.length; i++) {
        if (usersMasterList[i]
                .accountnumber
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            usersMasterList[i]
                .firstname
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            usersMasterList[i]
                .lastname
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString()) ||
            usersMasterList[i]
                .contactno
                .toString()
                .toLowerCase()
                .toString()
                .contains(word.toLowerCase().toString())) {
          usersList.add(usersMasterList[i]);
        }
      }
    } else {
      usersList.assignAll(usersMasterList);
    }
  }

  notifyConcessionaire(
      {required String fcmToken, required String message}) async {
    Get.find<NotificationServices>().sendNotification(
        userToken: fcmToken, message: message, title: "Account Notification");
  }

  @override
  void onInit() {
    getConcessionaires();
    super.onInit();
  }
}
