import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_application/blocs/dropdown_role_bloc/dropdown_role_bloc.dart';
import 'package:warehouse_application/repo/provider/login_provider.dart';
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
  LoginProvider loginProvider = LoginProvider();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController nama = TextEditingController();
  bool _hasBeenPressed = false;
  bool _obscureText = true;
  RoleApiRepository apiRepository = RoleApiRepository();
  // final Client roles = Client();
  // String _baseUrl = "https://asia-east2-warehouse-intern.cloudfunctions.net/fransTest/user/User_role";
  // String? valRoles; //= 'Client';
  // List<dynamic> _dataRole = List<dynamic>.empty();

  // @override
  // void initState() {
  //   super.initState();
  //   getRole();
  // }

  // void getRole() async {
  //   final respose = await roles.get(Uri.parse(_baseUrl));
  //   var listData = jsonDecode(respose.body);
    
  //   setState(() {
  //     _dataRole = listData;
  //   });
  //   print("data : $listData");
  // }

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
                          } else if (state is DropdownRoleDone) {  //MASIH ERRROR SAMPE 
                            return DropdownButton(
                              hint: Text('Select Role'),
                              value: '${state.role}',
                              items: state.role.map((item) {
                                return DropdownMenuItem(
                                  child: Text('${state.role}'),
                                  value: '${state.role}',
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  value = value as String;
                                });
                              },
                            );
                          }                                        //SINI
                          return Container();
                        }
                      ),
                    ),

                    // DropdownButton(
                    //   hint: Text('Select Role'),
                    //   value: valRoles,
                    //   items: _dataRole.map((item) {
                    //     return DropdownMenuItem(
                    //       child: Text(item['Role'],),
                    //       value: item['Role'],
                    //     );
                    //   }).toList(),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       valRoles = value as String;
                    //     });
                    //   },
                    // ),
                    

                    // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: TextFormField(controller: role,
                    //   decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Role *nanti diganti dropdown*',),),
                    // ),
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
















