import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:warehouse_application/repo/provider/login_provider.dart';


class DashManagerPage extends StatelessWidget {
  DashManagerPage({Key? key}) : super(key: key);
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
        // automaticallyImplyLeading: false,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(Icons.menu, size: 30,)
        // ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/userPage');
            },
            icon: Icon(Icons.account_circle_sharp, size: 30,),
          ),
        ]
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 15.0, 200.0, 15.0),
            child: Text("Dashboard", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 500.0,
                    height: 150.0,
                    child: new RaisedButton(
                      child: new Text('Warehouse'),
                      onPressed: () {Navigator.of(context).pushReplacementNamed('/warePage');},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 500.0,
                    height: 150.0,
                    child: new RaisedButton(
                      child: new Text('Stock'),
                      onPressed: () {Navigator.of(context).pushReplacementNamed('/stockPage');},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 500.0,
                    height: 150.0,
                    child: new RaisedButton(
                      child: new Text('Purchasing'),
                      onPressed: () {Navigator.of(context).pushReplacementNamed('/purchPage');},
                    ),
                  ),
                ),
              ]
            ),
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
                      Navigator.of(context).pushReplacementNamed('/userPage');
                    },
                    icon: Icon(Icons.account_circle_sharp, size: 30,),
                  ),
                  Text('NAMA USER**', style: TextStyle(fontSize: 30),),
                ],
              )
            ),
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
                  loginProvider.signOut(); Navigator.of(context).pushReplacementNamed('/login');
                }, 
                icon:Icon(Icons.logout, color: Colors.black,)
              ),
            ),
          ],
        ),
      )
    );
  }
}