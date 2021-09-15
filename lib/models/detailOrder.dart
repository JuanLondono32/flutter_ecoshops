import 'dart:convert';

class DetailOrder {
  DetailOrder({
    required this.amount,
    required this.finalPrice,
    required this.idOrder,
    required this.idProduct,
    this.id,
  });

  int amount;
  int finalPrice;
  int idOrder;
  int idProduct;
  String? id;

  factory DetailOrder.fromJson(String str) =>
      DetailOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailOrder.fromMap(Map<String, dynamic> json) => DetailOrder(
        amount: json["amount"],
        finalPrice: json["final_price"],
        idOrder: json["id_order"],
        idProduct: json["id_product"],
      );

  Map<String, dynamic> toMap() => {
        "amount": amount,
        "final_price": finalPrice,
        "id_order": idOrder,
        "id_product": idProduct,
      };
}
