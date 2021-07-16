import 'package:flutter/material.dart';

class ViewStockPage extends StatelessWidget {
  ViewStockPage({Key? key}) : super(key: key);

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
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 15.0, 200.0, 15.0),
            child: Text("View Stock", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.black)),
          ),
          ElevatedButton(
            onPressed: () {Navigator.of(context).pushReplacementNamed('/prePage');}, 
            child: Text("Back", style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    );
  }
}