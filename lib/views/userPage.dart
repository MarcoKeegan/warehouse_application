import 'package:flutter/material.dart';
import 'package:warehouse_application/repo/provider/login_provider.dart';


class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);
   LoginProvider loginProvider = LoginProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[400],
        centerTitle: true,
        title: Text('Warehouse',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        leading: IconButton(
          onPressed: () {Navigator.of(context).pushReplacementNamed('/dashM');},
          icon: Icon(Icons.arrow_back, size: 30,)
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(flex: 3), //2/6
            Text("User Page", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.black)),
            Spacer(flex: 1,), 
            
            IconButton(onPressed: () {loginProvider.signOut(); Navigator.of(context).pushReplacementNamed('/login');}, icon:Icon(Icons.logout, color: Colors.black,)),
            Spacer(flex: 3), // it will take 2/6 spaces
          ],
        ),
      ),
    );
  }
}