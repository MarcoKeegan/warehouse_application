import 'package:flutter/material.dart';

class WarehousePage extends StatelessWidget {
  WarehousePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[400],
        centerTitle: true,
        title: Text('Warehouse',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        leading: IconButton(
          onPressed: () {Navigator.of(context).pushReplacementNamed('/dashM');},
          icon: Icon(Icons.arrow_back, size: 30,)
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Spacer(flex: 3), //2/6
            Text("Warehouse Page", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.black)),
            Spacer(flex: 4,), 
          ],
        ),
      ),
    );
  }
}