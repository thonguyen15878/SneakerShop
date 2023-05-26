import 'package:flutter/material.dart';
import 'package:sneakerstore/widget/market_product.dart';

class Market extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Scaffold(
body: GridView.count(crossAxisCount: 2,
  childAspectRatio: 250/290,
  crossAxisSpacing: 8,
  mainAxisSpacing: 8,
  children: List.generate(100, (index) {
    return MarketProducts();
  }) ,),
    );
  }
}