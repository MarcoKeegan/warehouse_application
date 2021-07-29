import 'package:flutter/material.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({Key? key}) : super(key: key);

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
          onPressed: () {Navigator.of(context).pushReplacementNamed('/viewListStckPage');},
          icon: Icon(Icons.arrow_back, size: 30,)
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 15.0, 180.0, 15.0),
            child: Text("Add Product", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.black)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Nama Barang'),
            )
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Harga Barang'),
            )
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Deskripsi Barang',),),
          ),
          ElevatedButton(
            onPressed: () {Navigator.of(context).pushReplacementNamed('/viewListStckPage');}, 
            child: Text("Add Product", style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    );
  }
}