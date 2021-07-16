import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_application/route_manager.dart';

 class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuth.instance.currentUser == null? '/login': '/dashM',
      builder: (context, child) {
        return ColorfulSafeArea(
          color: Colors.white,
          child: child ?? DefaultNoInitialRoutePage(),
        );
      },
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}