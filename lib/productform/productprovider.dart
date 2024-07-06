import 'dart:convert';

import 'package:assesment/model/productmodel.dart';
import 'package:assesment/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<CartProduct> _cart = [];

  List<Product> get products => _products;
  List<CartProduct> get cart => _cart;

  void addProduct(Product product) {
    _products.add(product);
    
    notifyListeners();
  }

  void removeProduct(int index) {
    _products.removeAt(index);
    
    notifyListeners();
  }
  Future<void> saveProductsToSharedPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final productsJson = _products.map((product) => product.toJson()).toList();
      await prefs.setString('productList', jsonEncode(productsJson));
      print('Product list saved to SharedPreferences.');
    } catch (e) {
      print('Failed to save product list: $e');
    }
  }
 Future<void> logout(context) async {
    await saveProductsToSharedPreferences();
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => loginpage()));
  }
  void addToCart(Product product) {
    _cart.add(CartProduct(product: product, quantity: 1));
    notifyListeners();
  }
}

class CartProduct {
  final Product product;
  int quantity;

  CartProduct({required this.product, required this.quantity});
}


