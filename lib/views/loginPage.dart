import 'package:flutter/material.dart';
import 'package:warehouse_application/repo/provider/login_provider.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
   await Firebase.initializeApp();
  runApp(new MaterialApp(home: new LoginPage()));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  LoginProvider loginProvider = LoginProvider();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool _hasBeenPressed = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/gudang.jpg"), fit: BoxFit.cover
              )
            ),
            child: Column(
              children: [
                Spacer(flex: 1),
                Text('Warehouse', style: TextStyle(fontSize: 50),),
                // Spacer(flex: 1),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(controller: email,
                        decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Email',),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(controller: pass, obscureText: _obscureText,
                        decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Password', suffixIcon: IconButton(icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off), onPressed: () {setState(() {
                        _obscureText = !_obscureText;
                      });},)),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("LOGIN", style: TextStyle(color: Colors.white),),
                          color: Colors.blue,
                          onPressed: () {
                            loginProvider.loginWithEmailandPass(email.text.trim(),pass.text.trim()).then((value) {
                              if (value == 'text'){
                                Navigator.of(context).pushReplacementNamed('/dashM');
                              }else {
                                //Navigator.of(context).pushReplacementNamed('/dashC');
                                print('Error');
                                return Container();
                              }
                            }   
                            );
                          },
                        ),
                      ),
                      Center(
                        child: FlatButton(
                          child: Text("Don't have any Account? Register", style: TextStyle(color: Colors.black),),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/regis');
                          }
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 1,),
              ],
            ),
          )
        ],
      )
    );
  }
}


