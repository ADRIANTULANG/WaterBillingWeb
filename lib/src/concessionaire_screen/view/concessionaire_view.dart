import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:waterbilling/src/concessionaire_screen/widgets/concessionaire_listview.dart';

import '../controller/concessionaire_controller.dart';
import '../widgets/concessionaire_header_view.dart';

class ConcessionaireView extends GetView<ConcessionaireController> {
  const ConcessionaireView({super.key});
  static const String id = "concessionaire_tab";

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
                "Concessionaire",
                style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightGreen[900])),
                onPressed: () {
                  controller.getConcessionaires();
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
                  const ConcessionaireHeaderView(),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 2.h,
                  ),
                  const Expanded(
                    child: SizedBox(child: ConcessionaireListView()),
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
