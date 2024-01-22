import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waterbilling/models/chart_model.dart';
import 'package:waterbilling/src/dashboard_screen/controller/dashboard_controller.dart';

class DashboardChartView extends GetView<DashboardController> {
  const DashboardChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      width: 50.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 3)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: 2.w, right: 2.w, top: 3.h, bottom: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Data Charts",
                  style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Container(
                      height: 7.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 221, 218, 218),
                          borderRadius: BorderRadius.circular(8)),
                      child: Obx(
                        () => DropdownButton<int>(
                          value: controller.selectedYear.value,
                          padding: EdgeInsets.only(
                            left: 1.w,
                          ),
                          underline: const SizedBox(),
                          elevation: 16,
                          isExpanded: true,
                          onChanged: (int? value) {
                            // This is called when the user selects an item.
                            controller.selectedYear.value = value!;
                            controller.getWaterBills();
                          },
                          items: [
                            2011,
                            2012,
                            2013,
                            2014,
                            2015,
                            2016,
                            2017,
                            2018,
                            2019,
                            2020,
                            2021,
                            2022,
                            2023,
                            2024,
                            2025,
                            2026,
                            2028,
                            2029,
                            2030,
                            2031,
                          ].map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          onTap: () {
                            controller.selectedDataToCompare.value = "amount";
                            controller.getWaterBills();
                          },
                          value: "amount",
                          child: const Text('Amount'),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            controller.selectedDataToCompare.value = "usage";
                            controller.getWaterBills();
                          },
                          value: "usage",
                          child: const Text('Usage'),
                        ),
                      ],
                      child: const Icon(Icons.more_horiz_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 2.w,
              right: 2.w,
              top: 3.h,
            ),
            child: Obx(
              () => controller.selectedChart.value == "column"
                  ? SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                          minimum: 0,
                          maximum: controller.max.value,
                          interval: controller.interval.value),
                      series: <CartesianSeries<ChartData, String>>[
                          ColumnSeries<ChartData, String>(
                              dataSource: controller.chartdata,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              color: Colors.lightGreenAccent)
                        ])
                  : controller.selectedChart.value == "line"
                      ? SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          // primaryYAxis: NumericAxis(
                          //     minimum: 0,
                          //     maximum: controller.max.value,
                          //     interval: controller.interval.value),
                          series: <CartesianSeries<ChartData, String>>[
                              LineSeries<ChartData, String>(
                                  dataSource: controller.chartdata,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y,
                                  color: Colors.lightGreenAccent)
                            ])
                      : controller.selectedChart.value == "area"
                          ? SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              primaryYAxis: NumericAxis(
                                  minimum: 0,
                                  maximum: controller.max.value,
                                  interval: controller.interval.value),
                              series: <CartesianSeries<ChartData, String>>[
                                  AreaSeries<ChartData, String>(
                                      dataSource: controller.chartdata,
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y,
                                      color: Colors.lightGreenAccent)
                                ])
                          : controller.selectedChart.value == "bubble"
                              ? SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  primaryYAxis: NumericAxis(
                                      minimum: 0,
                                      maximum: controller.max.value,
                                      interval: controller.interval.value),
                                  series: <CartesianSeries<ChartData, String>>[
                                      BubbleSeries<ChartData, String>(
                                          dataSource: controller.chartdata,
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                          color: Colors.lightGreenAccent)
                                    ])
                              : SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  primaryYAxis: NumericAxis(
                                      minimum: 0,
                                      maximum: controller.max.value,
                                      interval: controller.interval.value),
                                  series: <CartesianSeries<ChartData, String>>[
                                      BarSeries<ChartData, String>(
                                          dataSource: controller.chartdata,
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y,
                                          color: Colors.lightGreenAccent)
                                    ]),
            ),
          ),
        ],
      ),
    );
  }
}
