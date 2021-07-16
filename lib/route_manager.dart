import 'package:flutter/material.dart';
import 'package:warehouse_application/views/dashboardClient.dart';
import 'package:warehouse_application/views/dashboardManager.dart';
import 'package:warehouse_application/views/loginPage.dart';
import 'package:warehouse_application/views/regisPage.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/regis':
        return MaterialPageRoute(builder: (context) => RegisPage());
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/dashM':
        return MaterialPageRoute(builder: (context) => DashManagerPage());
      case '/dashC':
        return MaterialPageRoute(builder: (context) => DashClientPage());
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