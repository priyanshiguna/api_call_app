// To parse this JSON data, do
//
//     final usersData = usersDataFromMap(jsonString);

import 'dart:convert';

List<UsersData> usersDataFromMap(String str) =>
    List<UsersData>.from(json.decode(str).map((x) => UsersData.fromMap(x)));

String usersDataToMap(List<UsersData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class UsersData {
  String? createdAt;
  String? name;
  String? avatar;
  String? id;

  UsersData({
    this.createdAt,
    this.name,
    this.avatar,
    this.id,
  });

  factory UsersData.fromMap(Map<String, dynamic> json) => UsersData(
        createdAt: json["createdAt"],
        name: json["name"],
        avatar: json["avatar"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "createdAt": createdAt,
        "name": name,
        "avatar": avatar,
        "id": id,
      };
}
