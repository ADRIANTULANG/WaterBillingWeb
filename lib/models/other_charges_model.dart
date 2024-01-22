import 'dart:convert';

List<OtherCharges> otherChargesFromJson(String str) => List<OtherCharges>.from(
    json.decode(str).map((x) => OtherCharges.fromJson(x)));

String otherChargesToJson(List<OtherCharges> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OtherCharges {
  String status;
  String chargetype;
  String amount;
  DateTime datecreated;
  String accountnumber;
  String id;

  OtherCharges({
    required this.status,
    required this.chargetype,
    required this.amount,
    required this.datecreated,
    required this.accountnumber,
    required this.id,
  });

  factory OtherCharges.fromJson(Map<String, dynamic> json) => OtherCharges(
        status: json["status"],
        chargetype: json["chargetype"],
        amount: json["amount"],
        datecreated: DateTime.parse(json["datecreated"]),
        accountnumber: json["accountnumber"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "chargetype": chargetype,
        "amount": amount,
        "datecreated": datecreated.toIso8601String(),
        "accountnumber": accountnumber,
        "id": id,
      };
}
