import 'dart:convert';

List<Payments> paymentsFromJson(String str) =>
    List<Payments>.from(json.decode(str).map((x) => Payments.fromJson(x)));

String paymentsToJson(List<Payments> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Payments {
  String accountNumber;
  DateTime dateuploaded;
  String reference;
  String clientName;
  double amountCollected;
  String id;

  Payments({
    required this.accountNumber,
    required this.dateuploaded,
    required this.reference,
    required this.clientName,
    required this.amountCollected,
    required this.id,
  });

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        accountNumber: json["accountNumber"],
        dateuploaded: DateTime.parse(json["dateuploaded"]),
        reference: json["reference"],
        clientName: json["clientName"],
        amountCollected: json["amountCollected"]?.toDouble(),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "dateuploaded": dateuploaded.toIso8601String(),
        "reference": reference,
        "clientName": clientName,
        "amountCollected": amountCollected,
        "id": id,
      };
}
