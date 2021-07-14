import 'package:flutter/material.dart';
import 'package:warehouse_application/repo/provider/login_provider.dart';


class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);
   LoginProvider loginProvider = LoginProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("assets/icons/bgquest.jpg"), fit: BoxFit.cover
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(flex: 3), //2/6
                  Image.asset('assets/images/logo.png', width: 300, height: 300,),
                  Text("Let's Play Trivia", style: TextStyle(fontSize: 50, fontStyle: FontStyle.italic, color: Colors.white)),
                  Spacer(flex: 1,), 
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/game');
                    },
                    child: Container(
                      width: 200,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20), // 15
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        "Lets Play",
                        style: TextStyle(fontSize: 15)
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {loginProvider.signOut(); Navigator.of(context).pushReplacementNamed('/login');}, icon:Icon(Icons.logout, color: Colors.white,)),
                  Spacer(flex: 3), // it will take 2/6 spaces
                ]
              )
            ),
          )
        ]
      )
    );
  }
}