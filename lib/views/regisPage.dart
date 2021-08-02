import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:warehouse_application/blocs/dropdown_role_bloc/dropdown_role_bloc.dart';
import 'package:warehouse_application/blocs/register_bloc/register_bloc.dart';
import 'package:warehouse_application/models/registerUser_model.dart';
import 'package:warehouse_application/models/userRole_model.dart';
import 'package:warehouse_application/repo/repositories/regisAPI_repository.dart';
import 'package:warehouse_application/repo/repositories/roleApi_repository.dart';

class RegisPage extends StatefulWidget {
  const RegisPage({Key? key, required RegisApiRepository regisApiRepository}) 
    : _regisApiRepository = regisApiRepository, super(key: key);

  final RegisApiRepository _regisApiRepository;

  @override
  _RegisPage createState() => _RegisPage();
}

class _RegisPage extends State<RegisPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();

  // Map<String, String> _authData = {
  //   'roleId': '',
  //   'name': '',
  //   'email': '',
  //   'password': '',
  // };

  // Future _submit() async {
  //   if (!_formKey.currentState!.validate()) {
  //     return;
  //   }
  //   _formKey.currentState!.save();
  // }
  late RegisterBloc _registerBloc;
  bool _obscureText = true;
  String? jabatan;

  @override
  void initState() {
    _registerBloc =
        RegisterBloc(regisRepository: widget._regisApiRepository);
    super.initState();
  }

  RoleApiRepository roleApiRepository = RoleApiRepository();
  RegisApiRepository provider = RegisApiRepository();

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
            

            child: MultiBlocProvider(
              providers: [
                BlocProvider<RegisterBloc>(
                  create: (BuildContext context) => RegisterBloc(regisRepository: provider),
                ),
                BlocProvider<DropdownRoleBloc>(
                  create: (BuildContext context) => DropdownRoleBloc(apiRepository: roleApiRepository),
                ),
              ],
              child: FormBuilder(
                key: _formKey,
                child: Column(
                children: [
                  Spacer(flex: 3),
                  Text("Warehouse", style: TextStyle(fontSize: 50, fontStyle: FontStyle.italic, color: Colors.black)),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    
                    children: [
                      _dropdownRole(),
                      _nameField(context),
                      _emailField(context),
                      _passField(context),
                      _regisButton(),
                      _showLoginButton(context),
                    ],
                  ),
                  Spacer(flex: 3,),
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
  // Widget _regisForm() {
  //   return BlocListener<RegisterBloc, RegisState>(
  //     listener: (context, state) {
  //       if (state is RegisFailed) {
  //         print('Register Failed!');
  //       }
  //     },
  //     child: Column(
  //       children: [
  //         Padding(
  //         padding: EdgeInsets.all(8.0),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             _dropdownRole(),
  //             _nameField(),
  //             _emailField(),
  //             _passField(),
  //             _regisButton(),
  //           ],
  //         ),
  //       ),
  //       ],
  //     ),
  //   );
  // }

  Widget _dropdownRole() {
    // return BlocProvider(create: (context) => DropdownRoleBloc(apiRepository: apiRepository),
    //   child: 
      return BlocBuilder<DropdownRoleBloc, DropdownRoleState>(
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
      );
    // );
  }

  Widget _nameField(BuildContext context) {
    // return BlocBuilder<RegisterBloc, RegisState>(
    //   builder: (context, state) {
        return Padding(
        padding: EdgeInsets.all(8.0),
          child: FormBuilderTextField(
            name: 'name',
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Name',),
            // validator: (value) {
            //   if (value!.isEmpty || value.length > 2) {
            //     return 'Name Too Short!';
            //   }
            // },
            // onSaved: (value) {
            //   _authData['name'] = value!;
            // },
            textInputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
          ),
      );
      // }
    // );
  }

  Widget _emailField(BuildContext context) {
    // return BlocBuilder<RegisterBloc, RegisState>(
    //   builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(8.0),
            child: FormBuilderTextField(
              name: 'email',
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Email',),
              // validator: (value) {
              //   if (value!.isEmpty || value.contains('@')) {
              //     return 'Invalid Email!';
              //   }
              // },
              // onSaved: (value) {
              //   _authData['email'] = value!;
              // },
             textInputAction: TextInputAction.next,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.email(context),
                FormBuilderValidators.required(context),
              ]),
            ),
        );
      // }
    // );
  }

  Widget _passField(BuildContext context) {
    // return BlocBuilder<RegisterBloc, RegisState>(
    //   builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(8.0),
            child: FormBuilderTextField(
              name: 'password',
            obscureText: _obscureText,
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Password', suffixIcon: IconButton(icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off), 
            onPressed: () {setState(() {
              _obscureText = !_obscureText;
            });},)),
            // validator: (value) {
            //   if (value!.isEmpty || value.length < 5) {
            //     return 'Password Too Short!';
            //   }
            // },
            // onSaved: (value) {
            //   _authData['password'] = value!;
            // },                    
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.minLength(context, 3),
              FormBuilderValidators.required(context),
          ]),
            ),
        );
    //   }
    // );
  }

  Widget _regisButton() {
    // return BlocBuilder<RegisterBloc, RegisState>(
    //   builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: Text("REGISTER", style: TextStyle(color: Colors.white),),
            color: Colors.blue,
            onPressed: () {
              if (_formKey.currentState!.saveAndValidate()) {
                _registerBloc.add(RequestRegis(
                  email: _formKey.currentState!.value['email'],
                  pass: _formKey.currentState!.value['password'],
                  nama: _formKey.currentState!.value['name'],
                  roleId: _formKey.currentState!.value['role']));
              }
            },
          ),
        );
    //   }
    // );
  }

  Widget _showLoginButton(BuildContext context) {
    // return BlocBuilder<RegisterBloc, RegisState>(
    //   builder: (context, state) {
        return Center(
          child: FlatButton(
            child: Text("Already have Account? Back to Login", style: TextStyle(color: Colors.black),),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/login');
            }
          ),
        );
      }
  //   );
  // }
  
}