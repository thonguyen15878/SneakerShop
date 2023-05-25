import 'package:flutter/material.dart';
import 'package:sneakerstore/screens/cart_empty.dart';
import 'package:sneakerstore/screens/cart_full.dart';

class Cart extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    List products = [];
    return Scaffold(
      // body: CartFull(),
      body:products.isEmpty? CartEmpty() : CartFull(),
    );
  }
}