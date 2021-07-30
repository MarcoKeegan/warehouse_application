import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:warehouse_application/repo/repositories/firebaseAPI_repository.dart';

void main() async {
   await Firebase.initializeApp();
  runApp(new MaterialApp(home: new LoginPage()));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'roleId': '',
    'name': '',
    'email': '',
    'password': '',
  };

  Future _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
  }

  // final _formKey = GlobalKey<FormState>();
  FirebaseRepository loginRepository = FirebaseRepository();
  // TextEditingController email = TextEditingController();
  // TextEditingController pass = TextEditingController();
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
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FormBuilderTextField(
                          // controller: email,
                          name: 'email',
                          decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Email',),
                          validator: (value) {
                              if (value!.isEmpty || value.contains('@')) {
                                return 'Invalid Email!';
                              }
                            },
                            onSaved: (value) {
                              _authData['email'] = value!;
                            },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FormBuilderTextField(
                          name: 'password', obscureText: _obscureText,
                        decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Password', suffixIcon: IconButton(icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off), 
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )),
                        validator: (value) {
                            if (value!.isEmpty || value.length < 5) {
                              return 'Password Too Short!';
                            }
                          },
                          onSaved: (value) {
                            _authData['password'] = value!;
                          }, 
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("LOGIN", style: TextStyle(color: Colors.white),),
                          color: Colors.blue,
                          onPressed: () {
                            // loginRepository.loginWithEmailandPass(email.text.trim(),pass.text.trim()).then((value) {
                            //   if (value == 'text'){
                            //     Navigator.of(context).pushReplacementNamed('/dashM');
                            //   }else {
                            //     //Navigator.of(context).pushReplacementNamed('/dashC');
                            //     print('Error');
                            //     return Container();
                            //   }
                            // }   
                            // );
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).pushReplacementNamed('/dashM');
                            } else {
                              print('Email or Password is invalid');
                            }
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


