import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneakerstore/providers/dark_theme_provider.dart';

import '../consts/colors.dart';
import '../inner_screen/product_details.dart';
import '../models/cart_attr.dart';
import '../providers/cart_provider.dart';
import '../services/global_method.dart';
class CartFull extends StatefulWidget {
  final String productId;

  const CartFull({required this.productId});
  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods =GlobalMethods();
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final cartAttr = Provider.of<CartAttr>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    double subTotal = cartAttr.price * cartAttr.quantity;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
          arguments: widget.productId),
      child: Container(
        height: 140,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
          color: Theme.of(context).colorScheme.background,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      cartAttr.imageUrl),
                  //  fit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'title',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32.0),
                          // splashColor: ,
                          onTap: () {
                            globalMethods.showDialogg(
                                'Remove item!',
                                'Product will be removed from the cart!',
                                    () => cartProvider
                                    .removeItem(widget.productId), context);
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Price: '),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${cartAttr.price}\$',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Sub Total: '),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${subTotal.toStringAsFixed(2)} \$',
                        style: TextStyle(

                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: themeChange.darkTheme
                                ? Colors.brown.shade900
                                : Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Ships Free',
                        style: TextStyle(
                            color: themeChange.darkTheme
                                ? Colors.brown.shade900
                                : Theme.of(context).colorScheme.secondary),
                      ),
                      Spacer(),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(32.0),
                          // splashColor: ,
                          onTap: cartAttr.quantity < 2
                              ? null
                              : () {
                            cartProvider.reduceItemByOne(
                              widget.productId,
                            );
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.remove,
                              color: cartAttr.quantity < 2
                                  ? Colors.grey
                                  : Colors.red,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 12,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.12,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              ColorsConsts.gradiendLStart,
                              ColorsConsts.gradiendLEnd,
                            ], stops: [
                              0.0,
                              0.7
                            ]),
                          ),
                          child: Text(
                            cartAttr.quantity.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4.0),
                          // splashColor: ,
                          onTap: () {
                            cartProvider.addProductToCart(
                                widget.productId,
                                cartAttr.price,
                                cartAttr.title,
                                cartAttr.imageUrl);
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.add,
                                color: Colors.green,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
