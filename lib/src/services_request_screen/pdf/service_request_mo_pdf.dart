import 'package:get/get.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:waterbilling/models/service_request_model.dart';
import 'package:universal_html/html.dart' as html;

import '../alertdialog/service_request_alertdialog.dart';

class ServiceRequestMissionOrderPdf {
  static Future<void> createPdf({required ServiceRequest requestdata}) async {
    ServiceRequestAlertDialog.showLoadingDialog();
    final Uint8List headerImage =
        (await rootBundle.load("assets/images/logo.png")).buffer.asUint8List();

    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
              child: pw.Column(children: [
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
              pw.Container(
                height: 50,
                width: 50,
                child: pw.Image(
                  pw.MemoryImage(
                    headerImage,
                  ),
                  fit: pw.BoxFit.cover,
                ),
                // child: pw.Container(
                //   color: PdfColor.fromHex("#66BB6A"),
                // ),
              ),
              pw.SizedBox(width: 20),
              pw.Column(
                children: [
                  pw.Text("Bocaue Water District",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      )),
                  pw.Text("Bocaue Bulacan",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.normal,
                      )),
                ],
              ),
            ]),
            pw.SizedBox(height: 24.0),
            pw.Center(
              child: pw.Text("Maintenance Order",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 20)),
            ),
            pw.SizedBox(height: 10.0),
            pw.Center(
              child: pw.Text("CTL CODE: ${requestdata.id}",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 9)),
            ),
            pw.SizedBox(height: 5.0),
            pw.Center(
              child: pw.Text(
                  "REQUEST DATE: ${DateFormat.yMMMd().format(requestdata.datecreated)}",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 9)),
            ),
            pw.SizedBox(height: 24.0),
            pw.Divider(),
            pw.SizedBox(height: 24.0),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                  children: [
                    pw.Text(
                      "Name: ",
                    ),
                    pw.Container(
                      width: 130,
                      padding: const pw.EdgeInsets.only(
                        bottom: 2,
                      ),
                      decoration: const pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        width: 1.0,
                      ))),
                      child: pw.Text(
                        "   ${requestdata.firstname} ${requestdata.lastname}",
                      ),
                    )
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      "Service Connection No: ",
                    ),
                    pw.Text("________________________",
                        style: const pw.TextStyle()),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 10.0),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(children: [
                    pw.Text(
                      "Address: ",
                    ),
                    pw.Container(
                      width: 120,
                      padding: const pw.EdgeInsets.only(
                        bottom: 2,
                      ),
                      decoration: const pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        width: 1.0,
                      ))),
                      child: pw.Text(
                        "   ${requestdata.address}",
                      ),
                    )
                  ]),
                  pw.Row(children: [
                    pw.Text(
                      "Customer Account No: ",
                    ),
                    pw.Container(
                      width: 160,
                      padding: const pw.EdgeInsets.only(
                        bottom: 2,
                      ),
                      decoration: const pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        width: 1.0,
                      ))),
                      child: pw.Text(
                        "   ${requestdata.accountNumber}",
                      ),
                    )
                  ]),
                ]),
            pw.SizedBox(height: 20.0),
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Column(children: [
                pw.Container(
                  height: 10,
                  width: 10,
                  color: requestdata.serviceType == 'Turn on'
                      ? PdfColor.fromHex("#000000")
                      : PdfColor.fromHex("#c7c7c7"),
                ),
                pw.SizedBox(height: 10.0),
                pw.Container(
                  height: 10,
                  width: 10,
                  color: requestdata.serviceType == 'Turn off'
                      ? PdfColor.fromHex("#000000")
                      : PdfColor.fromHex("#c7c7c7"),
                ),
                pw.SizedBox(height: 10.0),
                pw.Container(
                  height: 10,
                  width: 10,
                  color: requestdata.serviceType == 'Pull out'
                      ? PdfColor.fromHex("#000000")
                      : PdfColor.fromHex("#c7c7c7"),
                ),
                pw.SizedBox(height: 10.0),
                pw.Container(
                  height: 10,
                  width: 10,
                  color: requestdata.serviceType == 'Others'
                      ? PdfColor.fromHex("#000000")
                      : PdfColor.fromHex("#c7c7c7"),
                ),
                pw.SizedBox(height: 10.0),
                pw.Container(
                  height: 10,
                  width: 10,
                  color: requestdata.serviceType == 'Taping point'
                      ? PdfColor.fromHex("#000000")
                      : PdfColor.fromHex("#c7c7c7"),
                )
              ]),
              pw.SizedBox(width: 10),
              pw.Column(children: [
                pw.Container(height: 10, width: 50, child: pw.Text("Turn on")),
                pw.SizedBox(height: 10.0),
                pw.Container(height: 10, width: 50, child: pw.Text("Turn off")),
                pw.SizedBox(height: 10.0),
                pw.Container(height: 10, width: 50, child: pw.Text("Pull out")),
                pw.SizedBox(height: 10.0),
                pw.Container(height: 10, width: 50, child: pw.Text("Others")),
                pw.SizedBox(height: 10.0),
                pw.Container(
                    height: 10, width: 50, child: pw.Text("Taping point"))
              ]),
              pw.SizedBox(width: 150),
              pw.Column(children: [
                pw.Container(
                  height: 10,
                  width: 10,
                  color: requestdata.serviceType == 'Meter check'
                      ? PdfColor.fromHex("#000000")
                      : PdfColor.fromHex("#c7c7c7"),
                ),
                pw.SizedBox(height: 10.0),
                pw.Container(
                  height: 10,
                  width: 10,
                  color: requestdata.serviceType == 'Meter repair'
                      ? PdfColor.fromHex("#000000")
                      : PdfColor.fromHex("#c7c7c7"),
                ),
                pw.SizedBox(height: 10.0),
                pw.Container(
                  height: 10,
                  width: 10,
                  color: requestdata.serviceType == 'Meter replacement'
                      ? PdfColor.fromHex("#000000")
                      : PdfColor.fromHex("#c7c7c7"),
                ),
              ]),
              pw.SizedBox(width: 10),
              pw.Column(children: [
                pw.Container(
                    height: 10, width: 200, child: pw.Text("Meter check")),
                pw.SizedBox(height: 10.0),
                pw.Container(
                    height: 10, width: 200, child: pw.Text("Meter repair")),
                pw.SizedBox(height: 10.0),
                pw.Container(
                    height: 10,
                    width: 200,
                    child: pw.Text("Meter replacement")),
              ]),
            ]),
            pw.SizedBox(height: 40),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                // Header row
                pw.TableRow(
                  children: [
                    pw.Center(
                        child: pw.Text("Particulars",
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("Prev Reading",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("Meter no.",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("Size",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("Kind",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("Reading",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("Remarks",
                            style: const pw.TextStyle(fontSize: 11))),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Center(
                        child: pw.Text("Set",
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Center(
                        child: pw.Text("Remove",
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                  ],
                ),
                pw.TableRow(
                  children: [
                    pw.Center(
                        child: pw.Text("Others",
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                    pw.Center(
                        child: pw.Text("        ",
                            style: const pw.TextStyle(fontSize: 11))),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 40),
            pw.Row(
              children: [
                pw.Text("Recommending Approval: "),
                pw.SizedBox(width: 150),
                pw.Text("Approved: "),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                  children: [
                    pw.Text(
                      "Work Completed by: ",
                    ),
                    pw.Container(
                      width: 130,
                      padding: pw.EdgeInsets.only(
                        bottom: requestdata.employeeName == "" ? 10 : 2,
                      ),
                      decoration: const pw.BoxDecoration(
                          border: pw.Border(
                              bottom: pw.BorderSide(
                        width: 1.0,
                      ))),
                      child: pw.Text(
                        "   ${requestdata.employeeName} ",
                      ),
                    )
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      "Date: ",
                    ),
                    pw.Text("________________________",
                        style: const pw.TextStyle()),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Row(
                  children: [
                    pw.Text(
                      "Posted by: ",
                    ),
                    pw.Text("________________________",
                        style: const pw.TextStyle()),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      "Date: ",
                    ),
                    pw.Text("________________________",
                        style: const pw.TextStyle()),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 40),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text("__________________________",
                  style: const pw.TextStyle()),
            ),
            pw.Align(
              alignment: pw.Alignment.centerLeft,
              child: pw.Text("Concessionaire's Signature",
                  style: const pw.TextStyle()),
            ),
          ])); // Center
        })); //

    var savedFile = await pdf.save();
    List<int> fileInts = List.from(savedFile);

    html.AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
      ..setAttribute("download", "${DateTime.now().millisecondsSinceEpoch}.pdf")
      ..click();
    Get.back();
  }
}
