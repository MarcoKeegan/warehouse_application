
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:warehouse_application/blocs/dashboard_bloc/dashboard_bloc.dart';
// import 'package:warehouse_application/locator.dart';
// import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';
// import 'package:warehouse_application/views/dashboardManager.dart';

// class DashboardPage extends StatelessWidget {
//   DashboardPage({Key? key}) : super(key: key);
  
//   // WarehouseApiProvider dashprovider = WarehouseApiProvider();
  
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DashboardBloc()),
//       child: Builder(
//         builder: (context) => BlocBuilder<DashboardBloc, DashboardState>(
//           builder: (context, state) {
//             return DashManagerPage();
//           }),
//       ),
//     );
//   }
// }