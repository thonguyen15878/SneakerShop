import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneakerstore/consts/theme_data.dart';
import 'package:sneakerstore/providers/cart_provider.dart';
import 'package:sneakerstore/providers/dark_theme_provider.dart';
import 'package:sneakerstore/providers/favs_provider.dart';
import 'package:sneakerstore/providers/orders_provider.dart';
import 'package:sneakerstore/providers/products.dart';
import 'package:sneakerstore/screens/auth/forget_password.dart';
import 'package:sneakerstore/screens/auth/login.dart';
import 'package:sneakerstore/screens/auth/register.dart';
import 'package:sneakerstore/screens/bottom_bar.dart';
import 'package:sneakerstore/screens/landing_page.dart';
import 'package:sneakerstore/screens/cart.dart';
import 'package:sneakerstore/screens/wishlist.dart';
import 'inner_screen/brands_navigation_rail.dart';
import 'inner_screen/product_details.dart';
import 'loader.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeData, child) {
          return MaterialApp(
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home:(),
            routes: {
              BrandNavigationRailScreen.routeName: (ctx) =>
                  BrandNavigationRailScreen(key: ValueKey('myKey')),
              LoginScreen.routeName: (ctx) => LoginScreen(),
              RegisterScreen.routeName: (ctx) => RegisterScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              WishlistScreen.routeName: (ctx) => WishlistScreen(),
              ProductDetails.routeName: (ctx) => ProductDetails(),
              ForgetPassword.routeName: (ctx) => ForgetPassword(),
            },
          );
        },
      ),
    );
  }
}
