import 'package:flutter/material.dart';
import 'package:warehouse_application/models/readProduct_models.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';

class DetailStockPage extends StatefulWidget {
  const DetailStockPage({Key? key, required this.productId}) : super(key: key);

  @override
  _DetailStockPage createState() => _DetailStockPage();
  final int? productId;
}


class _DetailStockPage extends State<DetailStockPage> {
  WarehouseApiProvider provider = WarehouseApiProvider();
  // int? productId;
  
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
            padding: const EdgeInsets.fromLTRB(8.0, 15.0, 160.0, 15.0),
            child: Text("Detail Product", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 500.0,
              height: 50.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
              ),
              child: Text('Product 1', textAlign: TextAlign.center,),
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
              child: Text('Rp 25.000,00', textAlign: TextAlign.center,),
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
              child: Text('7 Left', textAlign: TextAlign.center,),
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
              child: Text('15 Stock', textAlign: TextAlign.center,),
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
              child: Text('Product ini digunakan untuk BLABLABLABLA', textAlign: TextAlign.center,),
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
              child: Text('Warehouse123**', textAlign: TextAlign.center,),
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
              child: Text('Alamat Warehouse**', textAlign: TextAlign.center,),
            )
          ),
          ElevatedButton(
            onPressed: () {Navigator.of(context).pushReplacementNamed('/addStockPage');}, 
            child: Text("Add Stock", style: TextStyle(color: Colors.black),),
          ),
          ElevatedButton(
            onPressed: () {}, 
            child: Text("Disable Product", style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    );
  }
}