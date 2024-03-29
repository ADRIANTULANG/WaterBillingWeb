import 'dart:convert';

List<WaterBilling> waterBillingFromJson(String str) => List<WaterBilling>.from(
    json.decode(str).map((x) => WaterBilling.fromJson(x)));

String waterBillingToJson(List<WaterBilling> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WaterBilling {
  DateTime billingDate;
  DateTime billingDateTimeStamp;
  double usage;
  double amount;
  double prevReading;
  double discount;
  DateTime dueDate;
  double presentReading;
  String clientName;
  String accountNumber;
  String id;
  bool isDue;
  bool isInterestAdded;
  bool isPenaltyAdded;
  double interest;
  double penalty;
  double originalAmount;

  WaterBilling({
    required this.billingDate,
    required this.billingDateTimeStamp,
    required this.usage,
    required this.amount,
    required this.prevReading,
    required this.discount,
    required this.dueDate,
    required this.presentReading,
    required this.clientName,
    required this.accountNumber,
    required this.id,
    required this.isDue,
    required this.isInterestAdded,
    required this.isPenaltyAdded,
    required this.interest,
    required this.penalty,
    required this.originalAmount,
  });

  factory WaterBilling.fromJson(Map<String, dynamic> json) => WaterBilling(
        billingDate: DateTime.parse(json["billingDate"]),
        billingDateTimeStamp: DateTime.parse(json["billingDateTimeStamp"]),
        usage: double.parse(json["usage"].toString()),
        amount: double.parse(json["amount"].toString()),
        penalty: double.parse(json["penalty"].toString()),
        originalAmount: double.parse(json["originalAmount"].toString()),
        interest: double.parse(json["interest"].toString()),
        prevReading: double.parse(json["prevReading"].toString()),
        discount: double.parse(json["discount"].toString()),
        dueDate: DateTime.parse(json["dueDate"]),
        presentReading: double.parse(json["presentReading"].toString()),
        clientName: json["clientName"],
        accountNumber: json["accountNumber"],
        id: json["id"],
        isDue: json["isDue"],
        isInterestAdded: json["isInterestAdded"],
        isPenaltyAdded: json["isPenaltyAdded"],
      );

  Map<String, dynamic> toJson() => {
        "billingDate": billingDate.toIso8601String(),
        "billingDateTimeStamp": billingDateTimeStamp.toIso8601String(),
        "usage": usage,
        "amount": amount,
        "prevReading": prevReading,
        "discount": discount,
        "dueDate": dueDate.toIso8601String(),
        "presentReading": presentReading,
        "clientName": clientName,
        "accountNumber": accountNumber,
        "id": id,
        "isDue": isDue,
      };
}
