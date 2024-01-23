// To parse this JSON data, do
//
//     final serviceRequest = serviceRequestFromJson(jsonString);

import 'dart:convert';

List<ServiceRequest> serviceRequestFromJson(String str) =>
    List<ServiceRequest>.from(
        json.decode(str).map((x) => ServiceRequest.fromJson(x)));

String serviceRequestToJson(List<ServiceRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceRequest {
  String serviceType;
  String firstname;
  String remarks;
  String lastname;
  String employeeName;
  String userid;
  String address;
  String accountNumber;
  DateTime datecreated;
  String employeeid;
  String contactno;
  bool status;
  String id;
  String others;
  List<String> images;

  ServiceRequest({
    required this.serviceType,
    required this.firstname,
    required this.remarks,
    required this.lastname,
    required this.employeeName,
    required this.userid,
    required this.address,
    required this.accountNumber,
    required this.datecreated,
    required this.employeeid,
    required this.contactno,
    required this.status,
    required this.id,
    required this.others,
    required this.images,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) => ServiceRequest(
        others: json["others"],
        images: List<String>.from(json["images"].map((x) => x)),
        serviceType: json["serviceType"],
        firstname: json["firstname"],
        remarks: json["remarks"],
        lastname: json["lastname"],
        employeeName: json["employeeName"],
        userid: json["userid"],
        address: json["address"],
        accountNumber: json["accountNumber"],
        datecreated: DateTime.parse(json["datecreated"]),
        employeeid: json["employeeid"],
        contactno: json["contactno"],
        status: json["status"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x)),
        "others": others,
        "serviceType": serviceType,
        "firstname": firstname,
        "remarks": remarks,
        "lastname": lastname,
        "employeeName": employeeName,
        "userid": userid,
        "address": address,
        "accountNumber": accountNumber,
        "datecreated": datecreated.toIso8601String(),
        "employeeid": employeeid,
        "contactno": contactno,
        "status": status,
        "id": id,
      };
}
