import '/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Products with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  Future<void> fetchProducts() async {
    print('Fetch method is called');
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productsSnapshot) {
      _products = [];
      productsSnapshot.docs.forEach((element) {
        // print('element.get(productBrand), ${element.get('productBrand')}');
        _products.insert(
          0,
          Product(
              id: element.get('productId') as String,
              title: element.get('productTitle') as String,
              description: element.get('productDescription') as String,
              price: double.parse(
                element.get('price')  as String,
              ) ,
              imageUrl: element.get('productImage') as String,
              brand: element.get('productBrand') as String,
              productCategoryName: element.get('productCategory') as String,
              quantity: int.parse(
                element.get('quantity') as String,
              ),
              isFavorite: true),
        );
      });
      notifyListeners();
    });
  }


  Product findById(String productId) {
    return _products.firstWhere((element) => element.id == productId);
  }

  List<Product> findByCategory(String categoryName) {
    List<Product> _categoryList = _products
        .where((element) =>
        element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<Product> findByBrand(String brandName) {
    List<Product> _categoryList = _products
        .where((element) =>
        element.brand.toLowerCase().contains(brandName.toLowerCase()))
        .toList();
    return _categoryList;
  }

  List<Product> searchQuery(String searchText) {
    List<Product> _searchList = _products
        .where((element) =>
        element.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }


}