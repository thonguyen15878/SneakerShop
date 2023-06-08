import 'dart:io';

import 'package:hexcolor/hexcolor.dart';
import 'package:sneakerstore/consts/colors.dart';
import 'package:sneakerstore/services/global_method.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/RegisterScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  bool _obscureText = true;
  String _emailAddress = '';
  String _password = '';
  String _fullName = '';
  late int _phoneNumber;
  File? _pickedImage;
  late String url;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    var date = DateTime.now().toString();
    var dateparse = DateTime.parse(date);
    var formattedDate = "${dateparse.day}-${dateparse.month}-${dateparse.year}";
    if (isValid) {

      _formKey.currentState!.save();
      try {
        if (_pickedImage == null) {
          _globalMethods.authErrorHandle('Please pick an image', context);
        } else{
          setState(() {
            _isLoading = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child('usersImages')
              .child(_fullName + '.jpg');
          await ref.putFile(_pickedImage!);
          url = await ref.getDownloadURL();
        await _auth.createUserWithEmailAndPassword(
            email: _emailAddress.toLowerCase().trim(),
            password: _password.trim());
        final User? user = _auth.currentUser;
        final _uid = user!.uid;
          user.updatePhotoURL(url);
          user.updateDisplayName(_fullName);
          user.reload();
        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'name': _fullName,
          'email': _emailAddress,
          'phoneNumber': _phoneNumber,
          'imageUrl': url,
          'joinedAt': formattedDate,
          'createdAt': Timestamp.now(),
        });
          Navigator.canPop(context) ? Navigator.pop(context) : null;
      }
      } catch (error) {
        _globalMethods.authErrorHandle(error.toString(), context);
        print('error occured ${error.toString()}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 10);
    if (pickedImage == null) {
      return; // User canceled image picking
    }
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return; // User canceled image picking
    }
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _remove() {
    setState(() {
      _pickedImage;
    });
    Navigator.pop(context);
  }

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
                      [
                        ColorsConsts.gradiendFStart,
                        ColorsConsts.gradiendLStart
                      ],
                      [ColorsConsts.gradiendFEnd, ColorsConsts.gradiendLEnd]
                    ],
                    durations: [
                      19440,
                      10800
                    ],
                    heightPercentages: [
                      0.20,
                      0.25
                    ],
                    blur: const MaskFilter.blur(BlurStyle.solid, 10),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight),
                waveAmplitude: 0,
                size: const Size(double.infinity, double.infinity),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 30),
                      child: CircleAvatar(
                        radius: 71,
                        backgroundColor: ColorsConsts.gradiendLEnd,
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: ColorsConsts.gradiendFEnd,
                          backgroundImage: _pickedImage == null
                              ? null
                              : FileImage(_pickedImage!),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: 120,
                      child: RawMaterialButton(
                        elevation: 10,
                        fillColor: ColorsConsts.gradiendLEnd,
                        child: const Icon(Icons.add_a_photo),
                        padding: const EdgeInsets.all(15),
                        shape: const CircleBorder(),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Choose an option',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: ColorsConsts.gradiendLStart),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      InkWell(
                                        onTap: _pickImageCamera,
                                        splashColor: HexColor('#f27f25'),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Icon(Icons.camera,
                                                  color: HexColor('#f27f25')),
                                            ),
                                            Text(
                                              'Camera',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorsConsts.title),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap:  _pickImageGallery,
                                        splashColor: HexColor('#f27f25'),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Icon(Icons.photo_album,
                                                  color: HexColor('#f27f25')),
                                            ),
                                            Text(
                                              'Gallery',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorsConsts.title),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: _remove,
                                        splashColor: HexColor('#f27f25'),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Icon(Icons.remove_circle,
                                                  color: HexColor('#f27f25')),
                                            ),
                                            Text(
                                              'Remove profile picture',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: ColorsConsts.title),
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
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          key: const ValueKey('username'),
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
                              prefixIcon: const Icon(Icons.person),
                              labelText: 'Username',
                              fillColor:
                                  Theme.of(context).colorScheme.background),
                          onSaved: (value) {
                            _fullName = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          key: const ValueKey('email'),
                          focusNode: _emailFocusNode,
                          validator: (value) {
                            if (value.toString().isEmpty ||
                                !value.toString().contains('@')) {
                              return 'Please enter a valid email address!';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passwordFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: const Icon(Icons.email),
                              labelText: 'Email',
                              fillColor:
                                  Theme.of(context).colorScheme.background),
                          onSaved: (value) {
                            _emailAddress = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          key: const ValueKey('phone number'),
                          focusNode: _phoneNumberFocusNode,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Phone number cannot be empty!';
                            } else if (value.toString().length < 10 &&
                                value.toString().length > 11) {
                              return 'Please enter a valid phone number!';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.next,
                          onEditingComplete: _submitForm,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: const Icon(Icons.phone_android),
                              labelText: 'Phone number',
                              fillColor:
                                  Theme.of(context).colorScheme.background),
                          onSaved: (value) {
                            _phoneNumber = int.parse(value!)!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: TextFormField(
                          key: const ValueKey('password'),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'Password cannot be empty!';
                            } else if (value.toString().length < 8) {
                              return 'Password must contain at least 8 characters!';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          focusNode: _passwordFocusNode,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              labelText: 'Password',
                              fillColor:
                                  Theme.of(context).colorScheme.background),
                          onSaved: (value) {
                            _password = value!;
                          },
                          obscureText: _obscureText,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_phoneNumberFocusNode),
                        ),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.all(12),
                      //   child: TextFormField(
                      //     key: ValueKey('confirm password'),
                      //     validator: (value) {
                      //       if (value.toString().isEmpty) {
                      //         return 'Password cannot be empty!';
                      //       }
                      //       else if (value.toString().length < 8) {
                      //         return 'Password must contain at least 8 characters!';
                      //       }
                      //       else if (value.toString() != _password) {
                      //         return 'Wrong password! Try again.';
                      //       }
                      //       return null;
                      //     },
                      //     textInputAction: TextInputAction.next,
                      //     keyboardType: TextInputType.emailAddress,
                      //     decoration: InputDecoration(
                      //         border: const UnderlineInputBorder(),
                      //         filled: true,
                      //         prefixIcon: Icon(Icons.lock),
                      //         suffixIcon: GestureDetector(
                      //           onTap: () {
                      //             setState(() {
                      //               _obscureText = !_obscureText;
                      //             });
                      //           },
                      //           child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                      //         ),
                      //         labelText: 'Confirm password',
                      //         fillColor: Theme.of(context).colorScheme.background
                      //     ),
                      //     onSaved: (value) {
                      //       _confirmPassword = value!;
                      //     },
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(
                                            color:
                                                ColorsConsts.backgroundColor),
                                      ),
                                    ),
                                  ),
                                  onPressed: _submitForm,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Join us',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17),
                                      ),
                                      SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                          const SizedBox(width: 20),
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
