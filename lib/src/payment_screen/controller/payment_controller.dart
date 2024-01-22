import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:waterbilling/models/payments_model.dart';

class PaymentController extends GetxController {
  RxList<Payments> paymentsList = <Payments>[].obs;
  RxList<Payments> paymentsMasterList = <Payments>[].obs;

  getPayments() async {
    try {
      var res = await FirebaseFirestore.instance
          .collection('paymentCollection')
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

  @override
  void onInit() {
    getPayments();
    super.onInit();
  }
}
