// import 'dart:js';

import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:warehouse_application/blocs/login_bloc/login_bloc.dart';
import 'package:warehouse_application/repo/repositories/firebaseAPI_repository.dart';

// void main() async {
//    await Firebase.initializeApp();
//   runApp(new MaterialApp(home: new LoginPage()));
// }

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

  FirebaseRepository loginRepository = FirebaseRepository();
  bool _hasBeenPressed = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/gudang.jpg"), fit: BoxFit.cover
              )
            ),
            
            child: BlocProvider(create: (context) => LoginBloc(firebaseAuthRepo: loginRepository),
              child: Builder(
                builder: (context) => Column(
                children: [
                  Spacer(flex: 1),
                  Text('Warehouse', style: TextStyle(fontSize: 50),),
                  // FormBuilder(
                  //   key: _formKey,
                     Column(
                      mainAxisSize: MainAxisSize.min,
                      
                      children: [
                        _loginForm(),
                        _showRegisButton(),
                      ],
                    ),
                  // ),
                  Spacer(flex: 1,),
                ],
            ),
              ),
            ),
          )
        ],
      )
    )
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          print('Login Failed!');
        }
      },
      child: Column(
        // key: _formKey,
        children:[ 
          Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _emailField(),
              _passField(),
              _loginButton(),
            ],
          ),
        ),
        ]
      )
    );
  }

  Widget _emailField() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return Padding(
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
          // onSaved: (value) {
          //   _authData['email'] = value!;
          // },
        ),
      );
    }
  );
}

Widget _passField() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: FormBuilderTextField(
        name: 'password', 
        obscureText: _obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(), 
          labelText: 'Password', 
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off), 
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
        // onSaved: (value) {
        //   _authData['password'] = value!;
        // },
          ) 
      );
    }
  );
}

Widget _loginButton() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return RaisedButton(
        child: Text("LOGIN", style: TextStyle(color: Colors.white),),
        color: Colors.blue,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.of(context).pushReplacementNamed('/dashM');
          } else {
            print('Email or Password is invalid');
          }
        },
      );
    }
  );
}

Widget _showRegisButton() {
  return BlocBuilder<LoginBloc, LoginState>(
    builder: (context, state) {
      return Center(
        child: FlatButton(
          child: Text("Don't have any Account? Register", style: TextStyle(color: Colors.black),),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/regis');
          }
        ),
      );
    },
  );
}


}

