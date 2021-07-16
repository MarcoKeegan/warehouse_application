import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:warehouse_application/repo/provider/login_provider.dart';


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
  TextEditingController role = TextEditingController();
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
              Spacer(flex: 3),
              Text("Warehouse", style: TextStyle(fontSize: 50, fontStyle: FontStyle.italic, color: Colors.black)),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(controller: role,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Role',),),
                    ),
                     Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(controller: role,
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
















