import 'package:flutter/material.dart';
import 'package:sneakerstore/consts/colors.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  String _username = '';
  String _fullname = '';
  String _emailAddress = '';
  String _password = '';
  String _confirmPassword = '';
  late int _phoneNumber;

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
                SizedBox(height: 30),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          key: ValueKey('username'),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Username cannot be empty!';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Username',
                              fillColor: Theme.of(context).colorScheme.background
                          ),
                          onSaved: (value) {
                            _username = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          key: ValueKey('fullname'),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Your full name cannot be empty!';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Full name',
                              fillColor: Theme.of(context).colorScheme.background
                          ),
                          onSaved: (value) {
                            _fullname = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          key: ValueKey('email'),
                          validator: (value) {
                            if (value.toString().isEmpty || value.toString().contains('@')) {
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
                          key: ValueKey('phone number'),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Phone number cannot be empty!';
                            }
                            else if (value.toString().length < 10 && value.toString().length > 11) {
                              return 'Please enter a valid phone number!';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.phone_android),
                              labelText: 'Phone number',
                              fillColor: Theme.of(context).colorScheme.background
                          ),
                          onSaved: (value) {
                            _phoneNumber = int.parse(value!)!;
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
                              labelText: 'Password',
                              fillColor: Theme.of(context).colorScheme.background
                          ),
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          key: ValueKey('confirm password'),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Password cannot be empty!';
                            }
                            else if (value.toString().length < 8) {
                              return 'Password must contain at least 8 characters!';
                            }
                            else if (value.toString() != _password) {
                              return 'Wrong password! Try again.';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Confirm password',
                              fillColor: Theme.of(context).colorScheme.background
                          ),
                          onSaved: (value) {
                            _confirmPassword = value!;
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
                      SizedBox(width: 10),
                      Row(
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
                        ],
                      )
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
