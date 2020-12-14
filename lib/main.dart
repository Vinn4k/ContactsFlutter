import 'package:alltolkit/views/login.dart';
import 'package:alltolkit/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'views/home_page.dart';

void main() async {

  runApp(MaterialApp(

    home: HomePage(),
    debugShowCheckedModeBanner: false,

  ));

}
