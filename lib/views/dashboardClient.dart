import 'package:flutter/material.dart';
import 'package:warehouse_application/repo/provider/login_provider.dart';


class DashClientPage extends StatelessWidget {
  DashClientPage({Key? key}) : super(key: key);
   LoginProvider loginProvider = LoginProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(flex: 3), //2/6
            Text("Dashboard Client", style: TextStyle(fontSize: 50, fontStyle: FontStyle.italic, color: Colors.black)),
            Spacer(flex: 1,), 
            
            IconButton(onPressed: () {loginProvider.signOut(); Navigator.of(context).pushReplacementNamed('/login');}, icon:Icon(Icons.logout, color: Colors.black,)),
            Spacer(flex: 3), // it will take 2/6 spaces
          ],
        ),
      )
    );
  }
}