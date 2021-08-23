import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:warehouse_application/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:warehouse_application/blocs/login_bloc/login_bloc.dart';
import 'package:warehouse_application/repo/repositories/createProduct_repository.dart';
import 'package:warehouse_application/repo/repositories/firebaseAPI_repository.dart';
import 'package:warehouse_application/repo/repositories/regisAPI_repository.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/addProduct_Page.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/addStock_Page.dart';
import 'package:warehouse_application/views/dashboardFolder/dashboard_runner.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/detailStock_Page.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/listViewStock_Page.dart';
import 'package:warehouse_application/views/loginFolder/loginPage.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/preViewStock_Page.dart';
import 'package:warehouse_application/views/dashboardFolder/purchaseFolder/purchasing_page.dart';
import 'package:warehouse_application/views/regisFolder/regisPage.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/stock_Page.dart';
import 'package:warehouse_application/views/dashboardFolder/userPageFolder/userPage.dart';
import 'package:warehouse_application/views/dashboardFolder/warehouseFolder/warehouse_Page.dart';

class App extends StatefulWidget {
  App(
      {Key? key,
      required FirebaseRepository firebaseAuth,
      required RegisApiRepository regisApiRepository,
      required CreateProductRepository createProductRepository})
      : _firebaseAuthRepo = firebaseAuth,
        _regisApiRepository = regisApiRepository,
        _createProductRepository = createProductRepository,
        super(key: key);

  final FirebaseRepository _firebaseAuthRepo;
  final RegisApiRepository _regisApiRepository;
  final CreateProductRepository _createProductRepository;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  late AuthenticationBloc _authBloc;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  void initState() {
    _authBloc = AuthenticationBloc(firebaseAuth: widget._firebaseAuthRepo);
    super.initState();
  }

  Future<void> _showLoading() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SpinKitFadingCircle(
            color: Colors.cyan,
            size: 50,
            controller: AnimationController(
                vsync: this, duration: const Duration(milliseconds: 2000)),
          );
        });
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
            return MaterialPageRoute(
                builder: (context) => AddProductPage(
                      createProductRepository: widget._createProductRepository,
                    ));
          case '/viewListStckPage':
            return MaterialPageRoute(builder: (context) => ListStockPage());
          // case '/detailStockPage':
          //   return MaterialPageRoute(builder: (context) => DetailStockPage());
          // case '/addStockPage':
          //   return MaterialPageRoute(builder: (context) => AddStockPage());
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
