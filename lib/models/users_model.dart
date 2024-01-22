import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  bool isActive;
  String contactno;
  DateTime datecreated;
  String firstname;
  String username;
  String password;
  bool isOnline;
  bool isAccepted;
  String lastname;
  String accountnumber;
  String id;
  String urlLink;
  String fcmToken;

  Users({
    required this.isActive,
    required this.contactno,
    required this.datecreated,
    required this.firstname,
    required this.username,
    required this.password,
    required this.isOnline,
    required this.isAccepted,
    required this.lastname,
    required this.accountnumber,
    required this.id,
    required this.urlLink,
    required this.fcmToken,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        isActive: json["isActive"],
        contactno: json["contactno"],
        datecreated: DateTime.parse(json["datecreated"]),
        firstname: json["firstname"],
        username: json["username"],
        password: json["password"],
        isOnline: json["isOnline"],
        isAccepted: json["isAccepted"],
        lastname: json["lastname"],
        accountnumber: json["accountnumber"],
        id: json["id"],
        urlLink: json["urlLink"],
        fcmToken: json["fcmToken"],
      );

  Map<String, dynamic> toJson() => {
        "isActive": isActive,
        "contactno": contactno,
        "datecreated": datecreated.toIso8601String(),
        "firstname": firstname,
        "username": username,
        "password": password,
        "isOnline": isOnline,
        "isAccepted": isAccepted,
        "lastname": lastname,
        "accountnumber": accountnumber,
        "urlLink": urlLink,
        "id": id,
        "fcmToken": fcmToken,
      };
}
