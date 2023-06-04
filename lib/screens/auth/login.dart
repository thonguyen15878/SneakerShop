import 'package:flutter/material.dart';
import 'package:sneakerstore/consts/colors.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  String _emailAddress = '';
  String _password = '';
  bool _obsecureText = true;

  @override
  // void dispose() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [ColorsConsts.gradiendFStart, ColorsConsts.gradiendLStart],
                    [ColorsConsts.gradiendFEnd, ColorsConsts.gradiendLEnd]
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.20, 0.25],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight
                ),
                waveAmplitude: 0,
                size: Size(
                  double.infinity,
                  double.infinity
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80),
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage('https://www.flaticon.com/free-icon/sneakers_1334205?term=sneaker&page=1&position=26&origin=search&related_id=1334205'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          key: ValueKey('email'),
                          validator: (value) {
                            if (value.toString().isEmpty || !value.toString().contains('@')) {
                              return 'Please enter a valid email address!';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            filled: true,
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email',
                            fillColor: Theme.of(context).colorScheme.background
                          ),
                          onSaved: (value) {
                            _emailAddress = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          key: ValueKey('password'),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Password cannot be empty!';
                            }
                            else if (value.toString().length < 8) {
                              return 'Password must contain at least 8 characters!';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obsecureText = !_obsecureText;
                                  });
                                },
                                child: Icon(_obsecureText ? Icons.visibility : Icons.visibility_off),
                              ),
                              labelText: 'Password',
                              fillColor: Theme.of(context).colorScheme.background
                          ),
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 20
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forget password?',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(
                                    color: ColorsConsts.backgroundColor
                                  ),
                                ),
                              ),
                            ),
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
                                ],
                              ),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
