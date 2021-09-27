import 'dart:convert';

class Account {
  Account({
    this.address,
    required this.birthDate,
    this.fullName,
    this.gender,
    required this.mail,
    required this.password,
    this.phone,
    this.id,
    required this.role,
  });

  String? address;
  DateTime birthDate;
  String? fullName;
  String? gender;
  String mail;
  String password;
  int? phone;
  String role;
  String? id;

  factory Account.fromJson(String str) => Account.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Account.fromMap(Map<String, dynamic> json) => Account(
        address: json["address"],
        birthDate: DateTime.parse(json["birth_date"]),
        fullName: json["full_name"],
        gender: json["gender"],
        mail: json["mail"],
        password: json["password"],
        phone: json["phone"],
        role: json["role"],
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
        "role": role
      };
}
