// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prt/src/provider/user_provider.dart';
import 'src/app.dart';
import 'package:provider/provider.dart';

const serverPath = "http://angle-app.test";

String? sharedToken;

void main() {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // sharedToken = prefs.getString('auth_token');

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: App(),
    ),
  );
}
