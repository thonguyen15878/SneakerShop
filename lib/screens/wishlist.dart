

import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:sneakerstore/widget/wishlist_full.dart';

import '../widget/wishlist_empty.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  //To be known 1) the amount must be an integer 2) the amount must not be double 3) the minimum amount should be less than 0.5 $
  @override
  Widget build(BuildContext context) {
    List wishlistList = [];
    return !wishlistList.isEmpty
        ? Scaffold(
      body: WishlistEmpty(),
    )
        : Scaffold(
  appBar: AppBar(
    title: Text('Wishlist ()'),
  ),
      body: ListView.builder(itemCount: 1,itemBuilder: (BuildContext ctx, int index){
        return WishlistFull();
      }),
    );
  }

}
