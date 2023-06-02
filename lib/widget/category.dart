import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {

   final int index;
    CategoryWidget({Key? key, required this.index}) : super(key: key);
  List<Map<String, Object>> categories = [
    {
      'categoryName': 'Sneaker for man',
      'categoryImagePath': 'assets/sneaker_for_men.png'
    },
    {
      'categoryName': 'Sneaker for women',
      'categoryImagePath': 'assets/sneaker_for_women.png'
    },
    {
      'categoryName': 'Sneaker for sport',
      'categoryImagePath': 'assets/run_sneaker.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image:
                  AssetImage(categories[index]['categoryImagePath'] as String),
              fit: BoxFit.cover
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 150,
          height: 150,
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: Theme.of(context).colorScheme.background,
            child: Text(
              categories[index]['categoryName'] as String,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  // color: Theme.of(context).colorScheme.background
                color: Colors.deepPurpleAccent
              ),
            ),
          ),
        ),
      ],
    );
  }
}