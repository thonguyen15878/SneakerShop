import 'package:flutter/material.dart';
import 'package:sneakerstore/screens/cart_empty.dart';

class Cart extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: CartEmpty(),
    );
  }
}