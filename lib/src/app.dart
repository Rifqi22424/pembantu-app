// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:prt/src/route_generator.dart';
import 'package:prt/src/widgets/scroll_behavior.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;

  const App({Key? key, this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        theme: ThemeData(
            useMaterial3: false,
            textTheme: TextTheme(
                headlineSmall: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'Asap'),
                titleMedium: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'Asap'),
                bodyMedium: TextStyle(
                    fontSize: 12,
                    // fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: 'Asap'))),
        scrollBehavior: NoGlowBehavior(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
