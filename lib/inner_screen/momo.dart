import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../providers/dark_theme_provider.dart';
import '../providers/products.dart';
import '../screens/bottom_bar.dart';

class Momo extends StatefulWidget {
  //To be known 1) the amount must be an integer 2) the amount must not be double 3) the minimum amount should be less than 0.5 $
  static const routeName = '/Momo';

  @override
  _MomoScreen createState() => _MomoScreen();
}

class _MomoScreen extends State<Momo> {
  GlobalKey previewContainer = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    // final productsData = Provider.of<Products>(context, listen: false);
    // final productId = ModalRoute.of(context)!.settings.arguments as String;
    // final prodAttr = productsData.findById(productId);




    final themeChange = Provider.of<DarkThemeProvider>(context);
    final productsData = Provider.of<Products>(context, listen: false);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final prodAttr = productsData.findById(productId);
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/momo1.png'),
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: 'your total payment: ',
                      style: TextStyle(
                        color: Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                    TextSpan(
                      text: '\$ ${prodAttr.price}',
                      style: TextStyle(
                        color: Colors.red, // Replace with your desired color
                      ),
                    ),
                  ],
                ),
              ),

            ),
            // SizedBox(height: 30),
            // Container(
            //   child: Text(
            //     'your payment: US \$ 50.0',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //         color: Theme.of(context).textSelectionTheme.selectionColor,
            //         fontSize: 25,
            //         fontWeight: FontWeight.w600),
            //   ),
            // ),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.red),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(BottomBarScreen.routeName);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Back To HomePage'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}