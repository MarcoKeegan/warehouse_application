import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_application/blocs/dashboard_bloc/dashboard_bloc.dart';
import 'package:warehouse_application/models/firebaseUser_models.dart';
import 'package:warehouse_application/views/dashboardManager.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPage createState() => _DashboardPage();
}

class _DashboardPage extends State<DashboardPage> {
  FirebaseUser firebaseUser = FirebaseUser(uid: '');

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (context) => DashboardBloc(firebaseUser: firebaseUser),
      child: DashManagerPage(),
    );
  }
}
