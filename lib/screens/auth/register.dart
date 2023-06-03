import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sneakerstore/consts/colors.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/RegisterScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  String _username = '';
  String _emailAddress = '';
  String _password = '';
  String _confirmPassword = '';
  bool _obsecureText = true;
  late int _phoneNumber;
  late File _pickedImage;

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
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 30
                      ),
                      child: CircleAvatar(
                        radius: 71,
                        backgroundColor: ColorsConsts.gradiendLEnd,
                        child: CircleAvatar(
                          radius: 65,
                          // backgroundImage: _pickedImage == null ? null : FileImage(_pickedImage),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 120,
                        left: 120,
                        child: RawMaterialButton(
                          elevation: 10,
                          fillColor: ColorsConsts.gradiendLEnd,
                          child: Icon(Icons.add_a_photo),
                          padding: EdgeInsets.all(15),
                          shape: CircleBorder(),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text(
                                          'Choose an option',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: ColorsConsts.gradiendLStart
                                        ),
                                      ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          InkWell(
                                            // onTap: () {},
                                            splashColor: HexColor('#f27f25'),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: Icon(
                                                      Icons.camera,
                                                      color: HexColor('#f27f25')
                                                  ),
                                                ),
                                                Text(
                                                  'Camera',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: ColorsConsts.title
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            // onTap: () {},
                                            splashColor: HexColor('#f27f25'),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: Icon(
                                                      Icons.photo_album,
                                                      color: HexColor('#f27f25')
                                                  ),
                                                ),
                                                Text(
                                                  'Gallery',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500,
                                                      color: ColorsConsts.title
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            // onTap: () {},
                                            splashColor: HexColor('#f27f25'),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: Icon(
                                                      Icons.remove_circle,
                                                      color: HexColor('#f27f25')
                                                  ),
                                                ),
                                                Text(
                                                  'Remove profile picture',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500,
                                                      color: ColorsConsts.title
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                            );
                          },
                        ),
                    ),
                  ],
                ),
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
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obsecureText = !_obsecureText;
                                  });
                                },
                                child: Icon(_obsecureText ? Icons.visibility : Icons.visibility_off),
                              ),
                              labelText: 'Confirm password',
                              fillColor: Theme.of(context).colorScheme.background
                          ),
                          onSaved: (value) {
                            _confirmPassword = value!;
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Join us',
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
