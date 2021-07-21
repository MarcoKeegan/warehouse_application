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
        leading: IconButton(
          onPressed: () {Navigator.of(context).pushReplacementNamed('/prePage');},
          icon: Icon(Icons.arrow_back, size: 30,)
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 15.0, 200.0, 15.0),
            child: Text("List Stock", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.black)),
          ),
          Card(
            child: Table(
              border: TableBorder(horizontalInside: BorderSide(width: 1, color: Colors.blue, style: BorderStyle.solid)),
              children: [
                TableRow(
                    decoration: BoxDecoration(color: Colors.white),
                  children :[
                    Text(' No ', style: TextStyle(fontSize: 20)),
                    Text('Barang ', style: TextStyle(fontSize: 20)),
                    Text('Stock', style: TextStyle(fontSize: 20)),
                    Text(' Price', style: TextStyle(fontSize: 20)),
                  ],
                  ),
              ],
            ),
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