import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:warehouse_application/blocs/dropdown_role_bloc/dropdown_role_bloc.dart';
import 'package:warehouse_application/models/userRole_model.dart';
import 'package:warehouse_application/repo/repositories/roleApi_repository.dart';


// void main() async {
//    await Firebase.initializeApp();
//   runApp(new MaterialApp(home: new RegisPage()));
// }

class RegisPage extends StatefulWidget {
  @override
  _RegisPage createState() => _RegisPage();
}

class _RegisPage extends State<RegisPage> {
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
  // RegisRepository regisRepo = RegisRepository();
  // TextEditingController email = TextEditingController();
  // TextEditingController pass = TextEditingController();
  // TextEditingController nama = TextEditingController();
  bool _hasBeenPressed = false;
  bool _obscureText = true;
  RoleApiRepository apiRepository = RoleApiRepository();
  String? jabatan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
          child: Stack(
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
                        // child: FormBuilder(
                        //   key: _formKey,
                          child: TextFormField(
                            // controller: nama,
                            decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Nama',),
                            validator: (value) {
                              if (value!.isEmpty || value.length > 2) {
                                return 'Name Too Short!';
                              }
                            },
                            onSaved: (value) {
                              _authData['name'] = value!;
                            },
                          ),
                        // ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        // child: FormBuilder(
                        //   key: _formKey,
                          child: TextFormField(
                            // controller: email,
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
                      // ),
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          // child: FormBuilder(
                          //   key: _formKey,
                            child: TextFormField(
                              // controller: pass, 
                            obscureText: _obscureText,
                            decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Password', suffixIcon: IconButton(icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off), 
                            onPressed: () {setState(() {
                              _obscureText = !_obscureText;
                            });},)),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 5) {
                                return 'Password Too Short!';
                              }
                            },
                            onSaved: (value) {
                              _authData['password'] = value!;
                            },                    
                            ),
                          // ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("REGISTER", style: TextStyle(color: Colors.white),),
                          color: Colors.blue,
                          onPressed: () {
                            _submit();
                            // regisRepo.regisEmailandPass(email.text.trim(),pass.text.trim()).then((value) {
                            //   if (value == 'text'){
                            //   Navigator.of(context).pushReplacementNamed('/login');
                            // }else {
                            //   print('error');
                            //   return Container();
                            // }
                            // } 
                            // );

                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).pushReplacementNamed('/login');
                            } else {
                              print('Nama or Email or Password is invalid');
                            }
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
      ),
    );
  }
}
















