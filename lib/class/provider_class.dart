import 'package:ecom_app/class/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];

  get totalProducts => products.length;

  get totalPrice {
    int price = 0;

    for (int i = 0; i < products.length; i++) {
      price = price + (products[i].price as int);
    }
    return price;
  }

  void addProduct({required Product data}) {
    products.add(data);
    notifyListeners();
  }

  void removeProduct({required Product data}) {
    products.remove(data);
    notifyListeners();
  }
}
