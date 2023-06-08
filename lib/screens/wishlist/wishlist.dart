
import 'package:sneakerstore/providers/favs_provider.dart';
import 'package:flutter/material.dart';
import 'package:sneakerstore/services/global_method.dart';

import 'package:provider/provider.dart';
import 'package:sneakerstore/screens/wishlist/wishlist_full.dart';

import 'wishlist_empty.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  //To be known 1) the amount must be an integer 2) the amount must not be double 3) the minimum amount should be less than 0.5 $
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final favsProvider = Provider.of<FavsProvider>(context);
    return favsProvider.getFavsItems.isEmpty
        ? Scaffold(body: WishlistEmpty())
        : Scaffold(
      appBar: AppBar(
        title: Text('Wishlist (${favsProvider.getFavsItems.length})'),
        actions: [
          IconButton(
            onPressed: () {
              globalMethods.showDialogg(
                  'Clear wishlist!',
                  'Your wishlist will be cleared!',
                      () => favsProvider.clearFavs(),
                  context);
              // cartProvider.clearCart();
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: favsProvider.getFavsItems.length,
        itemBuilder: (BuildContext ctx, int index) {
          return ChangeNotifierProvider.value(
              value: favsProvider.getFavsItems.values.toList()[index],
              child: WishlistFull(
                productId: favsProvider.getFavsItems.keys.toList()[index],
              ));
        },
      ),
    );

  }

}
