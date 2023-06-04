import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sneakerstore/consts/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sneakerstore/screens/auth/login.dart';
import 'package:sneakerstore/screens/auth/register.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  List<String> images = [
    'https://unsplash.com/photos/Qe3kgY98OXs',
    'https://unsplash.com/photos/_kY6w94o-f0',
    'https://unsplash.com/photos/Z6YxSbcIXT0',
    'https://unsplash.com/photos/sKYxVXKCSXk',
    'https://unsplash.com/photos/7TXuRFDe_Gk',
    'https://unsplash.com/photos/_BWzJXm9Yug',
    'https://unsplash.com/photos/bfOHFM7ollI',
    'https://unsplash.com/photos/kCB8aHEMCC0',
    'https://unsplash.com/photos/goNZjZWa5CY',
    'https://unsplash.com/photos/oARPb2dEOtQ'
  ];

  @override
  void initState() {
    super.initState();
    images.shuffle();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear)
    ..addListener(() {
      setState(() {});
    })
    ..addStatusListener((animationStatus) {
      if (animationStatus == AnimationStatus.completed) {
        _animationController.reset();
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(imageUrl: images[0],
          placeholder: (context, url) => Image.network('https://unsplash.com/photos/_kY6w94o-f0',
          fit: BoxFit.contain),
            errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: FractionalOffset(_animation.value, 0),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'WELCOME',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                  'Welcome to Bazaar - The biggest online shoes marketplace',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w400
                  ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(HexColor('#FAB913')),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: ColorsConsts.backgroundColor),
                          ),)
                        ),
                        onPressed: () {Navigator.pushNamed(context, LoginScreen.routeName);},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Log in',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                                FeatherIcons.user,
                                size: 18
                            ),
                          ],
                        ),
                      ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(HexColor('#e94436')),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(color: ColorsConsts.backgroundColor),
                            ),
                          ),
                      ),
                      onPressed: () {Navigator.pushNamed(context, RegisterScreen.routeName);},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign up',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            FeatherIcons.userPlus,
                            size: 18
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                      ),
                  ),
                  Text(
                    'Or continue with',
                    style: TextStyle(color: Colors.black)
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          color: Colors.black,
                          thickness: 2
                        ),
                      ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                    onPressed: (){},
                    // shape: StadiumBorder(),
                    // highlightBorderColor: Colors.red.shade200,
                    // borderSide: BorderSide(
                    //     width: 2,
                    //     color: Colors.red
                    // ),
                    child: Text('Google +'),
                  ),
                  OutlinedButton(
                    onPressed: (){},
                    // shape: StadiumBorder(),
                    // highlightBorderColor: Colors.blue.shade200,
                    // borderSide: BorderSide(
                    //     width: 2,
                    //     color: Colors.blue
                    // ),
                    child: Text('Facebook'),
                  ),
                  OutlinedButton(
                    onPressed: (){},
                    // shape: StadiumBorder(),
                    // highlightBorderColor: Colors.grey.shade200,
                    // borderSide: BorderSide(
                    //     width: 2,
                    //     color: Colors.grey
                    // ),
                    child: Text('Sign in as guest'),
                  ),
                ],
              ),
              SizedBox(height: 40),
            ],
          )
        ],
      ),
    );
  }
}
