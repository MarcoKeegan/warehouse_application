import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_application/blocs/dropdown_role_bloc/dropdown_role_bloc.dart';
import 'package:warehouse_application/models/userRole_model.dart';
import 'package:warehouse_application/repo/repositories/loginAPISementara_repository.dart';
import 'package:warehouse_application/repo/repositories/regisApiSementara_repository.dart';
import 'package:warehouse_application/repo/repositories/roleApi_repository.dart';


void main() async {
   await Firebase.initializeApp();
  runApp(new MaterialApp(home: new RegisPage()));
}

class RegisPage extends StatefulWidget {
  @override
  _RegisPage createState() => _RegisPage();
}

class _RegisPage extends State<RegisPage> {
  final _formKey = GlobalKey<FormState>();
  RegisApiRepository regisRepo = RegisApiRepository();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController nama = TextEditingController();
  bool _hasBeenPressed = false;
  bool _obscureText = true;
  RoleApiRepository apiRepository = RoleApiRepository();
  String? jabatan;

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
              Spacer(flex: 3),
              Text("Warehouse", style: TextStyle(fontSize: 50, fontStyle: FontStyle.italic, color: Colors.black)),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[


                    BlocProvider(create: (context) => DropdownRoleBloc(apiRepository: apiRepository),
                      child: BlocBuilder<DropdownRoleBloc, DropdownRoleState>(
                        builder: (context, state) {
                          if (state is DropdownRoleLoading) {
                            return Center(
                              child: CircularProgressIndicator(color: Colors.white),
                            );
                          } else if (state is DropdownRoleFailed) {
                            print('dropdown error');
                          } else if (state is DropdownRoleDone) { 
                            return DropdownButton(
                              hint: Text('Select Role',),
                              value: jabatan,                 
                              items: state.role.map((UserRole item) {     
                                return DropdownMenuItem(
                                  child: Text('${item.role}'),
                                  value: item.role,                
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  jabatan = newValue;
                                });
                              },
                            );
                          }                                  
                          return Container();
                        }
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(controller: nama,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Nama',),),
                    ),
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
                        child: Text("REGISTER", style: TextStyle(color: Colors.white),),
                        color: Colors.blue,
                        onPressed: () {
                          regisRepo.regisEmailandPass(email.text.trim(),pass.text.trim()).then((value) {
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
                    ),
                    Center(
                      child: FlatButton(
                        child: Text("Already have Account? Back to Login", style: TextStyle(color: Colors.black),),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        }
                      ),
                    ),
                  ],
                ),
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
















