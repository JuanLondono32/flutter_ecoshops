import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecoshops/models/detailOrder.dart';
import 'package:flutter_ecoshops/models/models.dart';
import 'package:flutter_ecoshops/models/order.dart';
import 'package:flutter_ecoshops/models/user.dart';

class OrderService extends ChangeNotifier {
  final List<DetailOrder> orders = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late DocumentReference _order;

  OrderService();

  void addDetail(String productID, int amount, Product product) {
    var newDetail = new DetailOrder(
        amount: amount,
        finalPrice: amount * product.price,
        idProduct: productID,
        product: product);

    orders.add(newDetail);
  }

  int getTotal() {
    var total = 0;
    orders.forEach((ord) {
      total = total + ord.finalPrice;
    });
    return total;
  }

  Future sendOrder(Account user) async {
    // Creando nueva orden
    var newOrder = new Order(
        address: user.address,
        idUser: user.id!,
        mail: user.mail,
        orderDate: DateTime.now(),
        status: "Confirmación pendiente.",
        tax: 19,
        totalPrice: this.getTotal());

    // Insertando la orden en la colección order
    _order = _firestore.collection('order').doc();
    await _order.set(newOrder.toMap());

    // Insertando detalles de orden
    await Future.forEach(orders, (DetailOrder ord) async {
      // Insertando el detalle de la orden
      var _detail = _order.collection('detail_order').doc();
      await _detail.set(ord.toMap());

      // Actualizando el stock del producto
      var _prod = _firestore.collection('product').doc(ord.idProduct);
      await _prod.update({'stock': ord.product!.stock - ord.amount});
    });
  }
}
