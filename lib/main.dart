import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/services/getstorage_services.dart';
import 'package:waterbilling/src/dashboard_screen/view/dashboard_tab_view.dart';
import 'package:waterbilling/src/dashboard_screen/view/dashboard_view.dart';
import 'package:waterbilling/src/employee_screen/view/employee_view.dart';
import 'package:waterbilling/src/login_screen/view/login_view.dart';
import 'package:waterbilling/src/other_charges_screen/view/other_charges_view.dart';
import 'package:waterbilling/src/payment_screen/view/payment_view.dart';
import 'package:waterbilling/src/splash_screen/view/splash_view.dart';
import 'package:waterbilling/src/water_bill_ledger_screen/view/water_bill_ledger_view.dart';

import 'services/notification_services.dart';
import 'src/concessionaire_screen/view/concessionaire_view.dart';
import 'src/services_request_screen/view/service_request_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDyz4lYYI8bcenHA7a4DjkKWQjTthG7Utg",
    authDomain: "waterbillingsystem-f2d04.firebaseapp.com",
    projectId: "waterbillingsystem-f2d04",
    storageBucket: "waterbillingsystem-f2d04.appspot.com",
    messagingSenderId: "739184153907",
    appId: "1:739184153907:web:8d276d6e8ab7dec222da46",
  ));
  Get.put(StorageServices());
  Get.put(NotificationServices());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        debugShowCheckedModeBanner: false,
        title: 'CSR/WBC',
        theme: ThemeData(
          fontFamily: "BariolNormal",
          primarySwatch: Colors.lightGreen,
        ),
        initialRoute: SplashView.id,
        routes: {
          SplashView.id: (context) => const SplashView(),
          LoginView.id: (context) => const LoginView(),
          DashboardView.id: (context) => const DashboardView(),
          DashboardTabView.id: (context) => const DashboardTabView(),
          ConcessionaireView.id: (context) => const ConcessionaireView(),
          WaterBillLedgerView.id: (context) => const WaterBillLedgerView(),
          OtherChargesView.id: (context) => const OtherChargesView(),
          ServiceRequestView.id: (context) => const ServiceRequestView(),
          EmployeeView.id: (context) => const EmployeeView(),
          PaymentView.id: (context) => const PaymentView(),
        },
      );
    });
  }
}
