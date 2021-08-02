import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_application/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:warehouse_application/repo/repositories/firebaseAPI_repository.dart';

class DashManagerPage extends StatelessWidget {
  DashManagerPage({Key? key}) : super(key: key);
  FirebaseRepository loginRepository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.cyan[400],
            centerTitle: true,
            title: Text(
              'Warehouse',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/userPage');
                },
                icon: Icon(
                  Icons.account_circle_sharp,
                  size: 30,
                ),
              ),
            ]),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 15.0, 200.0, 15.0),
              child: Text("Dashboard",
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.black)),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/warePage');
                    },
                    child: SizedBox(
                      width: 500,
                      height: 150,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Warehouse'),
                          ]),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/stockPage');
                    },
                    child: SizedBox(
                      width: 500,
                      height: 150,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Stock'),
                          ]),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/purchPage');
                    },
                    child: SizedBox(
                      width: 500,
                      height: 150,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Purchasing'),
                          ]),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.cyan[400],
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/userPage');
                        },
                        icon: Icon(
                          Icons.account_circle_sharp,
                          size: 30,
                        ),
                      ),
                      Text(
                        'NAMA USER**',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  )),
              ListTile(
                title: Text('Dashboard'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/dashM');
                },
              ),
              ListTile(
                title: Text('Warehouse'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/warePage');
                },
              ),
              ListTile(
                title: Text('Stock'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/stockPage');
                },
              ),
              ListTile(
                title: Text('Purchasing'),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/purchPage');
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LogoutRequested());
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.black,
                    )),
              ),
            ],
          ),
        ));
  }
}
