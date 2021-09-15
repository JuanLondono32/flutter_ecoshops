import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'ecoshops-1338f-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    this.loadProducts();
  }

  Future loadProducts() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'product.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });

    this.isLoading = false;
    notifyListeners();
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      // Es necesario crear
      await this.createProduct(product);
    } else {
      // Actualizar
      await this.updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'product/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    //final decodedData = resp.body;

    final index =
        this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'product.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];

    this.products.add(product);

    return product.id!;
  }

  Future<String> deleteProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'product/${product.id}.json');
    final resp = await http.delete(url, body: product.toJson());

    this.products.removeWhere((element) => element.id == product.id);

    return product.id!;
  }
}
