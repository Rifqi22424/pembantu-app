// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prt/src/provider/user_provider.dart';
import 'src/app.dart';
import 'package:provider/provider.dart';

const id = 2;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: App(),
    ),
  );
}
