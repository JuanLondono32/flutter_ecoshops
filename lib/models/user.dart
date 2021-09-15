import 'dart:convert';

class User {
  User({
    this.address,
    required this.birthDate,
    required this.fullName,
    required this.gender,
    required this.mail,
    required this.password,
    this.phone,
    this.id,
  });

  String? address;
  DateTime birthDate;
  String fullName;
  String gender;
  String mail;
  int password;
  int? phone;
  String? id;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        address: json["address"],
        birthDate: DateTime.parse(json["birth_date"]),
        fullName: json["full_name"],
        gender: json["gender"],
        mail: json["mail"],
        password: json["password"],
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "birth_date":
            "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "full_name": fullName,
        "gender": gender,
        "mail": mail,
        "password": password,
        "phone": phone,
      };
}
