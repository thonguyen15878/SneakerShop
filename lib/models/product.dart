import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String productCategoryName;
  final String brand;
  final int quantity;
  final bool isFavorite;

  Product({
    this.id = '',
    this.title = '',
    this.description = '',
    this.price = 0.0,
    this.imageUrl = '',
    this.productCategoryName = '',
    this.brand = '',
    this.quantity = 0,
    this.isFavorite = false,
  });


}
