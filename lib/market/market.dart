import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneakerstore/screens/wishlist/wishlist.dart';
import 'package:sneakerstore/market/market_product.dart';

import '../cart/cart.dart';
import '../consts/colors.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/favs_provider.dart';
import '../providers/products.dart';
import '../providers/products.dart';
import '../providers/products.dart';

class Market extends StatefulWidget {
  static const routeName = '/Market';

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  // void initState() {
  //   super.initState();
  //   Provider.of<Products>(context, listen: false).fetchProducts();
  // }

  Future<void> _getProductsOnRefresh() async {
    await Provider.of<Products>(context, listen: false).fetchProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    final popular = arguments is String ? arguments : 'default';
    final productsProvider = Provider.of<Products>(
      context,
    );

    List<Product> productsList = productsProvider.products;
    if (popular == 'popular') {
      productsList = productsProvider.popularProducts;
    }

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text('Market'),
        actions: [
          Consumer<FavsProvider>(
            builder: (_, favs, ch) => IconButton(
              icon: Icon(
                Icons.favorite,
                color: ColorsConsts.favColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(WishlistScreen.routeName);
              },
            ),
          ),
          Consumer<CartProvider>(
            builder: (_, cart, ch) => IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: ColorsConsts.cartColor,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _getProductsOnRefresh,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 240 / 420,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: List.generate(productsList.length,
                  (index) {
            return ChangeNotifierProvider.value(
              value: productsList[index],
              child: MarketProducts(),
            );
          }
          ),
        ),
      ),
    );
  }
}
