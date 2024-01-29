import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/services_request_screen/controller/service_request_controller.dart';
import 'package:waterbilling/src/services_request_screen/widgets/service_request_header_view.dart';

import '../widgets/service_request_list_view.dart';

class ServiceRequestView extends GetView<ServiceRequestController> {
  const ServiceRequestView({super.key});
  static const String id = "servicerequest";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Padding(
      padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h),
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Service Request",
                style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightGreen[900])),
                onPressed: () {
                  controller.getServiceRequest();
                },
                child: const Icon(Icons.refresh_rounded),
              )
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, spreadRadius: 1, blurRadius: 3)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  const ServiceRequestHeaderView(),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Expanded(
                    child: SizedBox(child: ServiceRequestListView()),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
