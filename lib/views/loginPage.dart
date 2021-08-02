import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:warehouse_application/blocs/login_bloc/login_bloc.dart';
import 'package:warehouse_application/repo/repositories/firebaseAPI_repository.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required FirebaseRepository firebaseAuthRepo})
      : _firebaseAuthRepo = firebaseAuthRepo,
        super(key: key);

  final FirebaseRepository _firebaseAuthRepo;

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  // bool autoValidate = true;
  late bool isPasswordShown;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    isPasswordShown = false;
    _loginBloc = LoginBloc(firebaseAuth: widget._firebaseAuthRepo);
    super.initState();
  }

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
            
            child: BlocProvider(create: (context) => _loginBloc,
              child: Builder(
                builder: (context) => Column(
                children: [
                  Spacer(flex: 1),
                  Text('Warehouse', style: TextStyle(fontSize: 50),),
                  // Spacer(flex: 1),
                  FormBuilder(
                    key: _formKey,
                     child: Column(
                      mainAxisSize: MainAxisSize.min,
                      
                      children: [
                        _emailField(context),
                        _passField(context),
                        _loginButton(),
                        _showRegisButton(context),
                      ],
                    ),
                  ),
                  Spacer(flex: 1,),
                ],
            ),
              ),
            ),
          )
        ],
      )
    );
  }

  // Widget _loginForm() {
  //   return BlocListener<LoginBloc, LoginState>(
  //     listener: (context, state) {
  //       if (state is LoginFailed) {
  //         print('Login Failed!');
  //       }
  //     },
  //     child: Column(
  //       children:[ 
  //         Padding(
  //         padding: EdgeInsets.all(8.0),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             _emailField(),
  //             _passField(),
  //             _loginButton(),
  //           ],
  //         ),
  //       ),
  //       ]
  //     )
  //   );
  // }

  Widget _emailField(BuildContext context) {
  // return BlocBuilder<LoginBloc, LoginState>(
  //   builder: (context, state) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: FormBuilderTextField(
        name: 'email',
        decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Email',),
        textInputAction: TextInputAction.next,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.email(context),
          FormBuilderValidators.required(context),
        ]),
        // validator: (value) {
        //     if (value!.isEmpty || value.contains('@')) {
        //       return 'Invalid Email!';
        //     }
        //   },
          // onSaved: (value) {
          //   _authData['email'] = value!;
          // },
        ),
      );
  //   }
  // );
}

Widget _passField(BuildContext context) {
  // return BlocBuilder<LoginBloc, LoginState>(
  //   builder: (context, state) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: FormBuilderTextField(
        name: 'password', 
        // obscureText: _obscureText,
        obscureText: !isPasswordShown,
        decoration: InputDecoration(
          border: OutlineInputBorder(), 
          labelText: 'Password', 
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordShown ? Icons.visibility_off : Icons.visibility), 
              onPressed: () {
                setState(() {
                  isPasswordShown = !isPasswordShown;
                });
              },
            )),
            // validator: (value) {
            //     if (value!.isEmpty || value.length < 5) {
            //       return 'Password Too Short!';
            //     }
            //   },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.minLength(context, 5),
              FormBuilderValidators.required(context),
            ]),
          ) 
      );
  //   }
  // );
}

Widget _loginButton() {
  // return BlocBuilder<LoginBloc, LoginState>(
  //   builder: (context, state) {
      return RaisedButton(
        child: Text("LOGIN", style: TextStyle(color: Colors.white),),
        color: Colors.blue,
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            _loginBloc.add(Login(
              email: _formKey.currentState!.value['email'],
              password: _formKey.currentState!.value['password']));
          }
        },
      );
  //   }
  // );
}

Widget _showRegisButton(BuildContext context) {
  // return BlocBuilder<LoginBloc, LoginState>(
  //   builder: (context, state) {
      return Center(
        child: FlatButton(
          child: Text("Don't have any Account? Register", style: TextStyle(color: Colors.black),),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/regis');
          }
        ),
      );
  //   },
  // );
}


}

