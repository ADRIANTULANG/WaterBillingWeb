import 'dart:convert';

List<Employees> employeesFromJson(String str) =>
    List<Employees>.from(json.decode(str).map((x) => Employees.fromJson(x)));

String employeesToJson(List<Employees> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employees {
  String contactno;
  String password;
  String type;
  DateTime datecreated;
  String firstname;
  String lastname;
  String username;
  String id;

  Employees({
    required this.contactno,
    required this.password,
    required this.type,
    required this.datecreated,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.id,
  });

  factory Employees.fromJson(Map<String, dynamic> json) => Employees(
        contactno: json["contactno"],
        password: json["password"],
        type: json["type"],
        datecreated: DateTime.parse(json["datecreated"]),
        firstname: json["firstname"],
        lastname: json["lastname"],
        username: json["username"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "contactno": contactno,
        "password": password,
        "type": type,
        "datecreated": datecreated.toIso8601String(),
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "id": id,
      };
}
