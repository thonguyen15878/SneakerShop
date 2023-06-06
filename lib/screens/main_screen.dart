import 'package:sneakerstore/screens/upload_product_form.dart';
import 'package:flutter/material.dart';

import 'bottom_bar.dart';

class MainScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomBarScreen()],
    );
  }
}
