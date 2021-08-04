import 'package:flutter/material.dart';

class PreViewStockPage extends StatelessWidget {
  PreViewStockPage({Key? key}) : super(key: key);

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
          onPressed: () {Navigator.of(context).pushReplacementNamed('/stockPage');},
          icon: Icon(Icons.arrow_back, size: 30,)
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 15.0, 200.0, 15.0),
            child: Text("View Stock", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 500.0,
              height: 50.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),
              child: Text('NAMA WAREHOUSE', textAlign: TextAlign.center,),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 500.0,
              height: 50.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),
              child: Text('ALAMAT WAREHOUSE', textAlign: TextAlign.center,),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 500.0,
              height: 50.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),
              child: Text('DESCRIPTION', textAlign: TextAlign.center,),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 500.0,
              height: 50.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),
              child: Text('JUMLAH BARANG', textAlign: TextAlign.center,),
            )
          ),
          Center(
            child: 
              ElevatedButton(
                onPressed: () {Navigator.of(context).pushReplacementNamed('/viewListStckPage');}, 
                child: Text("View Product", style: TextStyle(color: Colors.black),),
              ),
              // ElevatedButton(
              //   onPressed: () {Navigator.of(context).pushReplacementNamed('/addStckPage');}, 
              //   child: Text("Add Product", style: TextStyle(color: Colors.black),),
              // ),
            
          )
        ],
      ),
    );
  }
}