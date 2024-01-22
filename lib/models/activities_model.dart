import 'dart:convert';

List<Activities> activitiesFromJson(String str) =>
    List<Activities>.from(json.decode(str).map((x) => Activities.fromJson(x)));

String activitiesToJson(List<Activities> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Activities {
  DateTime datecreated;
  String employeeid;
  String userid;
  String activity;
  String username;
  String id;

  Activities({
    required this.datecreated,
    required this.employeeid,
    required this.userid,
    required this.activity,
    required this.username,
    required this.id,
  });

  factory Activities.fromJson(Map<String, dynamic> json) => Activities(
        datecreated: DateTime.parse(json["datecreated"]),
        employeeid: json["employeeid"],
        userid: json["userid"],
        activity: json["activity"],
        username: json["username"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "datecreated": datecreated.toIso8601String(),
        "employeeid": employeeid,
        "userid": userid,
        "activity": activity,
        "username": username,
        "id": id,
      };
}
