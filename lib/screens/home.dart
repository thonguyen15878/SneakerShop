import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';

import '../inner_screen/brands_navigation_rail.dart';
import '../providers/products.dart';
import '../widget/backlayer.dart';
import '../widget/category.dart';

class Home extends StatelessWidget {
  @override
  List _brandImages = [
    'assets/images/adidas.png',
    'assets/images/nike.png',
    'assets/images/puma.png'
  ];
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    productsData.fetchProducts();
    final popularItems = productsData.popularProducts;
    print('popularItems length ${popularItems.length}');
    return Scaffold(
      body: Center(
          child: BackdropScaffold(
            frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        headerHeight: MediaQuery.of(context).size.height * 0.25,
        appBar: BackdropAppBar(
          title: Text("WELCOME TO BAZAAR"),
          leading: BackdropToggleButton(
            icon: AnimatedIcons.list_view,
          ),
          actions: <Widget>[
            IconButton(
              iconSize: 20,
              padding: const EdgeInsets.all(10),
              icon: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 13,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
        backLayer: BackLayerMenu(),
        frontLayer: Column(
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
              height: 200,
                width: double.infinity,// adjust the height as needed
            ),
            SizedBox(height: 16), // add spacing between the image and other content
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Categories',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                  ),
                  Container(
                    height: 180,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext ctx, int index) {
                        return CategoryWidget(
                          index: index,
                        );

                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Brand',
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              BrandNavigationRailScreen.routeName,
                              arguments: {
                                3,
                              },
                            );
                          },
                          child: Text(
                            'View All...',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 210,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Swiper(
                      itemCount: _brandImages.length,
                      autoplay: true,
                      viewportFraction: 0.8,
                      scale: 0.9,
                      onTap: (index) {
                        Navigator.of(context).pushNamed(
                          BrandNavigationRailScreen.routeName,
                          arguments: {
                            index,
                          },
                        );
                      },
                      itemBuilder: (BuildContext ctx, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.blueGrey,
                            child: Image.asset(
                              _brandImages[index],
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),


          )),
    );
  }
}
