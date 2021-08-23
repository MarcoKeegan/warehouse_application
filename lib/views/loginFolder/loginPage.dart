import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

class _LoginPage extends State<LoginPage> with TickerProviderStateMixin {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();
  late bool isPasswordShown;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    isPasswordShown = false;
    _loginBloc = LoginBloc(firebaseAuth: widget._firebaseAuthRepo);
    super.initState();
  }

  Future<void> _showLoading() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SpinKitFadingCircle(
            color: Colors.cyan[400],
            size: 50,
            controller: AnimationController(
                vsync: this, duration: const Duration(milliseconds: 2000)),
          );
        });
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
                  image: AssetImage("images/gudang.jpg"), fit: BoxFit.cover)),
          child: BlocProvider(
            create: (context) => _loginBloc,
            child: Builder(
              builder: (context) => Column(
                children: [
                  Spacer(flex: 1),
                  Text(
                    'Warehouse',
                    style: TextStyle(fontSize: 50),
                  ),
                  FormBuilder(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Builder( 
                        builder: (context) => BlocListener<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is LoginLoading) {
                              print('Loading...');
                              _showLoading();
                            // } else if (state is LoginDone) {
                            //   Navigator.of(context).pop();
                            }
                          },
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
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }

  Widget _emailField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        name: 'email',
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
        ),
        textInputAction: TextInputAction.next,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.email(context),
          FormBuilderValidators.required(context),
        ]),
      ),
    );
  }

  Widget _passField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          name: 'password',
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
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.minLength(context, 6),
            FormBuilderValidators.required(context),
          ]),
        ));
  }

  Widget _loginButton() {
    return RaisedButton(
      child: Text(
        "LOGIN",
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blue,
      onPressed: () {
        if (_formKey.currentState!.saveAndValidate()) {
          _loginBloc.add(Login(
              email: _formKey.currentState!.value['email'],
              password: _formKey.currentState!.value['password']));
        }
      },
    );
  }

  Widget _showRegisButton(BuildContext context) {
    return Center(
      child: FlatButton(
          child: Text(
            "Don't have any Account? Register",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/regis');
          }),
    );
  }
}
