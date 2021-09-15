import 'dart:convert';

class Category {
  Category({
    this.descEnt,
    required this.nameCategory,
    this.id,
  });

  String? descEnt;
  String nameCategory;
  String? id;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        descEnt: json["desc_ent"],
        nameCategory: json["name_category"],
      );

  Map<String, dynamic> toMap() => {
        "desc_ent": descEnt,
        "name_category": nameCategory,
      };
}
