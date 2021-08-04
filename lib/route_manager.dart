import 'package:flutter/material.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/addProduct_Page.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/addStock_Page.dart';
import 'package:warehouse_application/views/dashboardFolder/dashboardManager.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/detailStock_Page.dart';
import 'package:warehouse_application/views/loginFolder/loginPage.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/preViewStock_Page.dart';
import 'package:warehouse_application/views/dashboardFolder/purchaseFolder/purchasing_page.dart';
import 'package:warehouse_application/views/regisFolder/regisPage.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/stock_Page.dart';
import 'package:warehouse_application/views/dashboardFolder/userPageFolder/userPage.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/listViewStock_Page.dart';
import 'package:warehouse_application/views/dashboardFolder/warehouseFolder/warehouse_Page.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/regis':
      //   return MaterialPageRoute(builder: (context) => RegisPage());
      // case '/login':
      //   return MaterialPageRoute(builder: (context) => LoginPage());
      // case '/dashM':
      //   return MaterialPageRoute(builder: (context) => DashManagerPage());
      // case '/userPage':
      //   return MaterialPageRoute(builder: (context) => UserPage());
      // case '/warePage':
      //   return MaterialPageRoute(builder: (context) => WarehousePage());
      // case '/stockPage':
      //   return MaterialPageRoute(builder: (context) => StockPage());
      // case '/purchPage':
      //   return MaterialPageRoute(builder: (context) => PurchPage());
      // case '/prePage':
      //   return MaterialPageRoute(builder: (context) => PreViewStockPage());
      // case '/addStckPage':
      //   return MaterialPageRoute(builder: (context) => AddProductPage());
      // case '/viewListStckPage':
      //   return MaterialPageRoute(builder: (context) => ListStockPage());
      // case '/detailStockPage':
      //   return MaterialPageRoute(builder: (context) => DetailStockPage());
      // case '/addStockPage':
      //   return MaterialPageRoute(builder: (context) => AddStockPage());
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
