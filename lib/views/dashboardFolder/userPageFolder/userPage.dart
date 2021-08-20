import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:warehouse_application/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:warehouse_application/repo/repositories/firebaseAPI_repository.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  FirebaseRepository loginRepository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[400],
        centerTitle: true,
        title: Text(
          'Warehouse',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            )),
      ),
      body: Center(
          child: SingleChildScrollView(
              child: Container(
        height: size.height * 0.9,
        child: Column(
          children: [
            _title(),
            _firebaseUID(),
            _userId(),
            _roleId(),
            _namaUser(),
            _email(),
            _logoutButton()
          ],
        ),
      ))),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 15.0, 180.0, 15.0),
      child: Text("User Page",
          style: TextStyle(
              fontSize: 30, fontStyle: FontStyle.italic, color: Colors.black)),
    );
  }

  Widget _userId() {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          initialValue: '23',
          name: 'namaB',
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'User ID',
          ),
          textInputAction: TextInputAction.next,
        ));
  }

  Widget _roleId() {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          initialValue: 'Manager',
          name: 'namaB',
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            // hintText: '${state.productID.data!.productName}',
            labelText: 'Role',
          ),
          textInputAction: TextInputAction.next,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
        ));
  }

  Widget _namaUser() {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          initialValue: 'NAMAAAAAAAAA',
          name: 'namaB',
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            // hintText: '${state.productID.data!.productName}',
            labelText: 'Nama User',
          ),
          textInputAction: TextInputAction.next,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
        ));
  }

  Widget _email() {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          initialValue: 'EMMMMMMMAAAAAAAILLLLLLL',
          name: 'namaB',
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            // hintText: '${state.productID.data!.productName}',
            labelText: 'Email',
          ),
          textInputAction: TextInputAction.next,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
        ));
  }

  Widget _firebaseUID() {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: FormBuilderTextField(
          initialValue: '5HAikyaWYcXS62b5EneqyXulOrt2',
          name: 'namaB',
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            // hintText: '${state.productID.data!.productName}',
            labelText: 'Firebase UID',
          ),
          textInputAction: TextInputAction.next,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
        ));
  }

  Widget _logoutButton() {
    return IconButton(
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context).add(LogoutRequested());
        },
        icon: Icon(
          Icons.logout,
          color: Colors.black,
        ));
  }
}
