import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationServices extends GetxController {
  // SEND NOTIF
  sendNotification(
      {required String userToken,
      required String from,
      required String message,
      required String title}) async {
    var body = jsonEncode({
      "to": userToken,
      "notification": {
        "body": message,
        "title": title,
        "subtitle": "",
      }
    });
    var res = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          "Authorization":
              "key=AAAArBrPFTM:APA91bGfXl5u9TEccukbNY2iUpMhI5Szlw2Kp4_7UKNYngqJGArQVi4djpr5U8TrW02aU9IzQRVbY79ToxnY171r7iHJMhKKBDMO5i0sTJ9Z1VUUMswWr4ed8CMZ_HBb-t89AhHwMnkz",
          "Content-Type": "application/json"
        },
        body: body);
    if (res.statusCode == 200) {
      if (from == 'payment collection' || from == 'save water bill') {
      } else {
        Get.snackbar("Message", "Successfully notified.",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    }
  }
}
