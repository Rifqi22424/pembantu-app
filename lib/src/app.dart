// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:prt/main.dart';
import 'package:prt/src/route_generator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        theme: ThemeData(useMaterial3: false),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
