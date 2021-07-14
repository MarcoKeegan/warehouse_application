import 'package:flutter/material.dart';
import 'package:warehouse_application/views/homePage.dart';
import 'package:warehouse_application/views/login.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/':
        return MaterialPageRoute(builder: (context) => Homepage());
      // case '/game':
      //   return MaterialPageRoute(builder: (context) => GamePageRunner());
      // case '/end':
      //   final int endScore =
      //       (settings.arguments as Map<String, dynamic>)['score'];
      //   return MaterialPageRoute(
      //       builder: (context) => EndScore(endScore: endScore));
      default:
        return MaterialPageRoute(
            builder: (context) => _DefaultErrorRoutePage(settings: settings));
    }
  }
}

class _DefaultErrorRoutePage extends StatelessWidget {
  const _DefaultErrorRoutePage({
    Key? key,
    required this.settings,
  }) : super(key: key);

  final RouteSettings settings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text('No Route Found for "${settings.name}"'),
      ),
    );
  }
}

class DefaultNoInitialRoutePage extends StatelessWidget {
  const DefaultNoInitialRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text('No InitialRoute Pushed'),
      ),
    );
  }
}