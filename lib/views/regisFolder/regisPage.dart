import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:warehouse_application/blocs/dropdown_role_bloc/dropdown_role_bloc.dart';
import 'package:warehouse_application/blocs/register_bloc/register_bloc.dart';
import 'package:warehouse_application/models/userRole_model.dart';
import 'package:warehouse_application/repo/repositories/regisAPI_repository.dart';
import 'package:warehouse_application/repo/repositories/roleApi_repository.dart';

class RegisPage extends StatefulWidget {
  const RegisPage({Key? key, required RegisApiRepository regisApiRepository})
      : _regisApiRepository = regisApiRepository,
        super(key: key);

  final RegisApiRepository _regisApiRepository;

  @override
  _RegisPage createState() => _RegisPage();
}

class _RegisPage extends State<RegisPage> with TickerProviderStateMixin {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();
  late RegisterBloc _registerBloc;
  bool _obscureText = true;
  String? jabatan;

  @override
  void initState() {
    _registerBloc = RegisterBloc(regisRepository: widget._regisApiRepository);
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

  RoleApiRepository roleApiRepository = RoleApiRepository();
  RegisApiRepository provider = RegisApiRepository();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: FormBuilder(
            child: Stack(
      children: [
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/gudang.jpg"), fit: BoxFit.cover)),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<RegisterBloc>(
                create: (BuildContext context) => _registerBloc,
              ),
              BlocProvider<DropdownRoleBloc>(
                create: (BuildContext context) =>
                    DropdownRoleBloc(apiRepository: roleApiRepository),
              ),
            ],
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
                child: Container(
                  height: size.height * 0.9,
                  child: Column(
                    children: [
                      Spacer(flex: 3),
                      Text("Warehouse",
                          style: TextStyle(
                              fontSize: 50,
                              fontStyle: FontStyle.italic,
                              color: Colors.black)),
                      Builder(
                        builder: (context) =>
                            BlocListener<RegisterBloc, RegisState>(
                          listener: (context, state) {
                            if (state is RegisLoading) {
                              print('Loading...');
                              _showLoading();
                            } else if (state is RegisDone) {
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            } else if (state is RegisFailedErrorParam) {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                      title: Text('ALERT!'),
                                      content: Text(
                                          'Something went wrong, please try again later.'),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            } else if (state is RegisFailedEmailUsedFb) {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                      title: Text('ALERT!'),
                                      content: Text(
                                          'This email address already registered in our database. Try another email.'),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            } else if (state is RegisFailedEmailUsed) {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                      title: Text('ALERT!'),
                                      content: Text(
                                          'There is already account with this email address. Try another email.'),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            } else if (state
                                is RegisFailedErrorInternalServer) {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (builder) {
                                    return AlertDialog(
                                      title: Text('ALERT!'),
                                      content: Text(
                                          'Something went wrong on our server, please try again later.'),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('OK'),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            }
                          },
                          child: Column(
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
                        ),
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    )));
  }

  Widget _dropdownRole() {
    return BlocBuilder<DropdownRoleBloc, DropdownRoleState>(
        builder: (context, state) {
      if (state is DropdownRoleLoading) {
        return Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      } else if (state is DropdownRoleFailed) {
        print('dropdown error');
      } else if (state is DropdownRoleDone) {
        return Padding(
            padding: EdgeInsets.all(8.0),
            child: FormBuilderDropdown(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: Text(
                'Select Role',
              ),
              name: 'role',
              items: state.role.map((UserRole item) {
                return DropdownMenuItem(
                  child: Text('${item.role}'),
                  value: item.roleId,
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  // jabatan = newValue;
                  newValue == 1 ? jabatan = 'manager' : jabatan = 'client';
                });
              },
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
              ]),
            ));
      }
      return Container();
    });
  }

  Widget _nameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        name: 'name',
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Name',
        ),
        textInputAction: TextInputAction.next,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
        ]),
      ),
    );
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
        obscureText: _obscureText,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
            suffixIcon: IconButton(
              icon:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )),
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.minLength(context, 6),
          FormBuilderValidators.required(context),
        ]),
      ),
    );
  }

  Widget _regisButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        child: Text(
          "REGISTER",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blue,
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            _registerBloc.add(RequestRegis(
              email: _formKey.currentState!.value['email'],
              pass: _formKey.currentState!.value['password'],
              nama: _formKey.currentState!.value['name'],
              roleId: _formKey.currentState!.value['role'],
            ));
          }
        },
      ),
    );
  }

  Widget _showLoginButton(BuildContext context) {
    return Center(
      child: FlatButton(
          child: Text(
            "Already have Account? Back to Login",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/login');
          }),
    );
  }
}
