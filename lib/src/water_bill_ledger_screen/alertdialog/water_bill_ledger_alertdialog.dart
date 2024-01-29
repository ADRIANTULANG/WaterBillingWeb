import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaterBillLedgerAlertDialog {
  static showLoadingDialog() {
    Get.dialog(const AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      content: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // The loading indicator
            CircularProgressIndicator(),
            SizedBox(
              height: 15,
            ),
            // Some text
            Text('Loading...')
          ],
        ),
      ),
    ));
  }
}
