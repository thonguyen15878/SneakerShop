import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MarketProducts extends StatefulWidget {
  @override
  _MarketProductsState createState() => _MarketProductsState();
}

class _MarketProductsState extends State<MarketProducts>{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 290,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
      color: Theme.of(context).backgroundColor),
    );
  }
}