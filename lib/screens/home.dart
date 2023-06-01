import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widget/category.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: BackdropScaffold(
            frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        headerHeight: MediaQuery.of(context).size.height * 0.25,
        appBar: BackdropAppBar(
          title: Text("Home"),
          leading: BackdropToggleButton(
            icon: AnimatedIcons.list_view,
          ),
          actions: <Widget>[
            IconButton(
              iconSize: 15,
              padding: const EdgeInsets.all(10),
              icon: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 13,
                  backgroundImage: AssetImage('assets/emptycart.png'),
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
        backLayer: Center(
          child: Text("Back Layer"),
        ),
        frontLayer: SingleChildScrollView(
          child: Column(

              children: [
                CarouselSlider(
                  items: [
                    Container(
                      width: 500,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Image.asset('assets/shoes.png', fit: BoxFit.cover),
                    ),
                    Container(
                      width: 500,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Image.asset('assets/shoes1.png', fit: BoxFit.cover),
                    ),
                    Container(
                      width: 500,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Image.asset('assets/shoes2.png', fit: BoxFit.cover),
                    ),
                    Container(
                      width: 500,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Image.asset('assets/shoes3.png', fit: BoxFit.cover),
                    ),
                    Container(
                      width: 500,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Image.asset('assets/shoes4.png', fit: BoxFit.cover),
                    ),
                    Container(
                      width: 500,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Image.asset('assets/shoes5.png' , fit: BoxFit.cover,),
                    ),
                    // Image.asset('assets/shoes1.png'),
                    // Image.asset('assets/shoes2.png'),
                    // Image.asset('assets/shoes3.png'),
                    // Image.asset('assets/shoes4.png'),
                    // Image.asset('assets/shoes5.png'),
                  ],
                  options: CarouselOptions(
                    height: 300,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  )),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                  Text(
                    'Categories',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),


                ),
                Container(
                  height: 180,
                  child: ListView.builder(itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, int index){
                      return CategoryWidget(index: index,);
                    },),
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
                     TextButton(onPressed: (){},
                         child: Text(
                           'View All...',
                           style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Colors.red),
                         )
                     )
                   ],
                 ),
               ),


                Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 120,

                        child: Image.asset('assets/adidas.png'),

                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        height: 150,

                        child: Image.asset('assets/nike.png'),
                      ),
                    ],
                  ),
                )

              ]
    ),
        ),

      )),
    );
  }
}
