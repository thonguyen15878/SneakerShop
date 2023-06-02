import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneakerstore/consts/theme_data.dart';
import 'package:sneakerstore/providers/dark_theme_provider.dart';
import 'package:sneakerstore/screens/bottom_bar.dart';

import 'inner_screen/brands_navigation_rail.dart';
import 'loader.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
void getCurrentAppTheme() async {
  themeChangeProvider.darkTheme = await themeChangeProvider.darkThemePreferences.getTheme();
}
@override
  void initState() {

  getCurrentAppTheme();
    super.initState();
  }
  @override
  Widget build(BuildContext context){

    return MultiProvider(
        providers: [
      ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
      })
    ],
    child: Consumer<DarkThemeProvider>(
        builder: (context, themeData, child) {
        return MaterialApp(

          theme: Styles.themeData(themeChangeProvider.darkTheme, context) ,
          home: BottomBarScreen(),
            routes: {
              BrandNavigationRailScreen.routeName: (ctx) =>
                  BrandNavigationRailScreen(key: ValueKey('myKey'),)
            }
        );
      }
    ));
  }
}

