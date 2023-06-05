import 'dart:io';

import 'package:sneakerstore/consts/colors.dart';
import 'package:sneakerstore/services/global_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadProductForm extends StatefulWidget {
  static const routeName = '/UploadProductForm';
  @override
  _UploadProductFormState createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

