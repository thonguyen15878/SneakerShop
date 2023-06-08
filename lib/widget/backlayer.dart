import 'package:flutter/material.dart';
import 'package:sneakerstore/screens/wishlist/wishlist.dart';

import '../cart/cart.dart';
import '../consts/colors.dart';
import '../screens/upload_product_form.dart';
import '../search/search.dart';







class BackLayerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  ColorsConsts.starterColor,
                  ColorsConsts.endColor,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        Positioned(
          top: -100.0,
          left: 140.0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.3),
              ),
              width: 150,
              height: 250,
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          right: 100.0,
          child: Transform.rotate(
            angle: -0.8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.3),
              ),
              width: 150,
              height: 300,
            ),
          ),
        ),
        Positioned(
          top: -50.0,
          left: 60.0,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.3),
              ),
              width: 150,
              height: 200,
            ),
          ),
        ),
        Positioned(
          bottom: 10.0,
          right: 0.0,
          child: Transform.rotate(
            angle: -0.8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white.withOpacity(0.3),
              ),
              width: 150,
              height: 200,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  // child: Container(
                  //   padding: const EdgeInsets.all(8.0),
                  //   height: 100,
                  //   width: 100,
                  //   decoration: BoxDecoration(
                  //       color: Theme.of(context).colorScheme.background,
                  //       borderRadius: BorderRadius.circular(10.0)),
                  //   child: Container(
                  //     //   clipBehavior: Clip.antiAlias,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(20.0),
                  //         image: DecorationImage(
                  //           image: NetworkImage(
                  //               'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                  //           fit: BoxFit.fill,
                  //         )),
                  //   ),
                  // ),
                ),
                const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context, Search.routeName);
                }, 'search', 0),
                const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context, CartScreen.routeName);
                }, 'Cart', 1),
                const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context, WishlistScreen.routeName);
                }, 'Wishlist', 2),
                const SizedBox(height: 10.0),
                content(context, () {
                  navigateTo(context, UploadProductForm.routeName);
                }, 'Upload a new product', 3),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List _contentIcons = [
    Icons.search,
    Icons.shopping_cart,
    Icons.favorite,
    Icons.assignment_turned_in
  ];
  void navigateTo(BuildContext ctx, String routeName) {
    Navigator.of(ctx).pushNamed(
      routeName,
    );
  }

  Widget content(BuildContext ctx, VoidCallback  fct, String text, int index) {
    return InkWell(
      onTap: fct,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
          Icon(_contentIcons[index])
        ],
      ),
    );
  }
}
