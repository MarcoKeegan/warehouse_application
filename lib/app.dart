import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_application/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:warehouse_application/repo/repositories/firebaseAPI_repository.dart';
import 'package:warehouse_application/repo/repositories/regisAPI_repository.dart';
import 'package:warehouse_application/views/addProduct_Page.dart';
import 'package:warehouse_application/views/addStock_Page.dart';
import 'package:warehouse_application/views/dashboardManager.dart';
import 'package:warehouse_application/views/dashboard_runner.dart';
import 'package:warehouse_application/views/detailStock_Page.dart';
import 'package:warehouse_application/views/listViewStock_Page.dart';
import 'package:warehouse_application/views/loginPage.dart';
import 'package:warehouse_application/views/preViewStock_Page.dart';
import 'package:warehouse_application/views/purchasing_page.dart';
import 'package:warehouse_application/views/regisPage.dart';
import 'package:warehouse_application/views/stock_Page.dart';
import 'package:warehouse_application/views/userPage.dart';
import 'package:warehouse_application/views/warehouse_Page.dart';

class App extends StatefulWidget {
  App(
      {Key? key,
      required FirebaseRepository firebaseAuth,
      required RegisApiRepository regisApiRepository})
      : _firebaseAuthRepo = firebaseAuth,
        _regisApiRepository = regisApiRepository,
        super(key: key);

  final FirebaseRepository _firebaseAuthRepo;
  final RegisApiRepository _regisApiRepository;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late AuthenticationBloc _authBloc;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  void initState() {
    _authBloc = AuthenticationBloc(firebaseAuth: widget._firebaseAuthRepo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) => BlocProvider(
        create: (context) => _authBloc,
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.Authenticated) {
              _navigator?.pushReplacementNamed('/dashM');
            } else if (state.status == AuthenticationStatus.Unauthenticated) {
              _navigator?.pushReplacementNamed('/login');
            }
          },
          child: child,
        ),
      ),
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? '/login' : '/dashM',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return MaterialPageRoute(
                builder: (context) => LoginPage(
                      firebaseAuthRepo: widget._firebaseAuthRepo,
                    ));
          case '/dashM':
            return MaterialPageRoute(builder: (context) => DashboardPage());
          case '/regis':
            return MaterialPageRoute(
                builder: (context) => RegisPage(
                      regisApiRepository: widget._regisApiRepository,
                    ));
          case '/userPage':
            return MaterialPageRoute(builder: (context) => UserPage());
          case '/warePage':
            return MaterialPageRoute(builder: (context) => WarehousePage());
          case '/stockPage':
            return MaterialPageRoute(builder: (context) => StockPage());
          case '/purchPage':
            return MaterialPageRoute(builder: (context) => PurchPage());
          case '/prePage':
            return MaterialPageRoute(builder: (context) => PreViewStockPage());
          case '/addStckPage':
            return MaterialPageRoute(builder: (context) => AddProductPage());
          case '/viewListStckPage':
            return MaterialPageRoute(builder: (context) => ListStockPage());
          case '/detailStockPage':
            return MaterialPageRoute(builder: (context) => DetailStockPage());
          case '/addStockPage':
            return MaterialPageRoute(builder: (context) => AddStockPage());
        }
      },
      // debugShowCheckedModeBanner: false,
      // initialRoute: FirebaseAuth.instance.currentUser == null? '/login': '/dashM',
      // builder: (context, child) {
      //   return ColorfulSafeArea(
      //     color: Colors.white,
      //     child: child ?? DefaultNoInitialRoutePage(),
      //   );
      // },
      // onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
