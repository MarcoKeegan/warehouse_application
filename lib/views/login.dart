import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_application/repo/provider/login_provider.dart';


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
  final bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("assets/icons/bgquest.jpg"), fit: BoxFit.cover
              )
            ),
          
          child: Column(
            children: [
              Spacer(flex: 1),
              Image.asset('assets/images/logo.png', width: 300, height: 300,),
              Text("Let's Play Trivia", style: TextStyle(fontSize: 50, fontStyle: FontStyle.italic, color: Colors.white)),
              Spacer(flex: 1),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                right: -40.0,
                                top: -40.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: CircleAvatar(
                                    child: Icon(Icons.close),
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ),
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
                                      child: TextFormField(controller: pass,
                                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Password'),obscureText: obscureText),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RaisedButton(
                                        child: Text("LOGIN", style: TextStyle(color: Colors.white),),
                                        color: Colors.blue,
                                        onPressed: () {
                                          loginProvider.loginWithEmailandPass(email.text.trim(),pass.text.trim()).then((value) {
                                            if (value == 'text'){
                                            Navigator.of(context).pushReplacementNamed('/');
                                          }else {
                                            print('error');
                                            return Container();
                                          }
                                          } 
                                          
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Text("Login", style: TextStyle(fontSize: 30),),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                right: -40.0,
                                top: -40.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: CircleAvatar(
                                    child: Icon(Icons.close),
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ),
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
                                      child: TextFormField(controller: pass,
                                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Password',), obscureText: obscureText),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RaisedButton(
                                        child: Text("REGISTER", style: TextStyle(color: Colors.white),),
                                        color: Colors.blue,
                                        onPressed: () {
                                          loginProvider.regisEmailandPass(email.text.trim(),pass.text.trim()).then((value) {
                                            if (value == 'text'){
                                            Navigator.of(context).pushReplacementNamed('/login');
                                          }else {
                                            print('error');
                                            return Container();
                                          }
                                          } 
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Text("Register", style: TextStyle(fontSize: 30),),
              ),
              Spacer(flex:3)
            ]
          )
          ) 
        ]
      ),
    );
  }
}