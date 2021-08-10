import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_application/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:warehouse_application/repo/repositories/firebaseAPI_repository.dart';


class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);
   FirebaseRepository loginRepository = FirebaseRepository();

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
            
            IconButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(LogoutRequested());
              },
            icon:Icon(Icons.logout, color: Colors.black,)),
            Spacer(flex: 3), // it will take 2/6 spaces
          ],
        ),
      ),
    );
  }
}