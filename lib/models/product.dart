import 'dart:convert';

class Product {
  Product({
    required this.categoryProd,
    this.descp,
    required this.idEntrepreneurship,
    this.image,
    required this.nameProd,
    required this.price,
    required this.stock,
    this.id,
  });

  String? categoryProd;
  String? descp;
  int idEntrepreneurship;
  String? image;
  String nameProd;
  int price;
  int stock;
  String? id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        categoryProd: json["category_prod"],
        descp: json["descp"],
        idEntrepreneurship: json["id_entrepreneurship"],
        image: json["image"],
        nameProd: json["name_prod"],
        price: json["price"],
        stock: json["stock"],
      );

  Map<String, dynamic> toMap() => {
        "category_prod": categoryProd,
        "descp": descp,
        "id_entrepreneurship": idEntrepreneurship,
        "image": image,
        "name_prod": nameProd,
        "price": price,
        "stock": stock,
      };

  Product copy() => Product(
        categoryProd: this.categoryProd,
        descp: this.descp,
        idEntrepreneurship: this.idEntrepreneurship,
        image: this.image,
        nameProd: this.nameProd,
        price: this.price,
        stock: this.stock,
        id: this.id,
      );
}
