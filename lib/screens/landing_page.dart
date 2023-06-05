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
import 'package:sneakerstore/services/global_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;
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
  Future<void> _googleSignIn() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          var date = DateTime.now().toString();
          var dateparse = DateTime.parse(date);
          var formattedDate =
              "${dateparse.day}-${dateparse.month}-${dateparse.year}";
          final authResult = await _auth.signInWithCredential(
              GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken));
          await FirebaseFirestore.instance
              .collection('users')
              .doc(authResult.user!.uid)
              .set({
            'id': authResult.user!.uid,
            'name': authResult.user!.displayName,
            'email': authResult.user!.email,
            'phoneNumber': authResult.user!.phoneNumber,
            'imageUrl': authResult.user!.photoURL,
            'joinedAt': formattedDate,
            'createdAt': Timestamp.now(),
          });
        } catch (error) {
          // _globalMethods.authErrorHandle(error.message, context);
        }
      }
    }
  }
  void _loginAnonymosly() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInAnonymously();
    }
    // catch (error) {
    //   _globalMethods.authErrorHandle(error.message, context);
    //   print('error occured ${error.message}');
    // }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white, // Set the background color to yellow
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            child: Image.asset('assets/shop.png',
            // placeholder: (context, url) => Image.network('https://unsplash.com/photos/_kY6w94o-f0',
            // fit: BoxFit.contain),
            //   errorWidget: (context, url, error) => Icon(Icons.error),
            // fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            // alignment: FractionalOffset(_animation.value, 0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 80),
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 30),
                //   child: Text(
                //   '',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontSize: 26,
                //     fontWeight: FontWeight.w400
                //   ),
                //   ),
                // ),
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
                    onPressed: _googleSignIn,
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
                  _isLoading
                      ? CircularProgressIndicator()
                      : OutlinedButton(
                    onPressed: (){_loginAnonymosly();},
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
