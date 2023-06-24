import 'package:flutter/material.dart';
import 'package:sneakerstore/consts/colors.dart';
import 'package:sneakerstore/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';

import '../screens/bottom_bar.dart';
import '../search/search.dart';
class CartEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/empty-cart.png'),
                //   image: NetworkImage(
                //       'https://assets.materialup.com/uploads/16e7d0ed-140b-4f86-9b7e-d9d1c04edb2b/preview.png'
                //   )
              ),
            ),
          ),
          Text(
            'Your Cart Is Empty',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontSize: 36,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Looks Like You didn\'t \n add anything to your cart yet',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: themeChange.darkTheme
                    ? Theme.of(context).disabledColor
                    : ColorsConsts.subTitle,
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 30,
          ),

          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red),
            ),
            child: ElevatedButton(
              onPressed: () => {
                Navigator.of(context).pushNamed(BottomBarScreen.routeName),
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Shop now'.toUpperCase(),
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
    );
  }


}
