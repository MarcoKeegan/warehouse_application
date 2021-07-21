import 'package:flutter/material.dart';

class AddStockPage extends StatelessWidget {
  AddStockPage({Key? key}) : super(key: key);

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
            child: Text("Add Stock", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.black)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Nama Warehouse *nanti diganti dropdown*',),),
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
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Jumlah Barang'),
            )
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Harga Barang'),
            )
          ),
          ElevatedButton(
            onPressed: () {Navigator.of(context).pushReplacementNamed('/prePage');}, 
            child: Text("Add Stock", style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    );
  }
}