import 'package:flutter/material.dart';

class StockPage extends StatelessWidget {
  StockPage({Key? key}) : super(key: key);

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
          onPressed: () {Navigator.of(context).pushReplacementNamed('/dashM');},
          icon: Icon(Icons.arrow_back, size: 30,)
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 15.0, 270.0, 15.0),
            child: Text("Stock", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {Navigator.of(context).pushReplacementNamed('/prePage');},
                    child: SizedBox(
                      width: 500,
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Warehouse123'),
                        ]
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {Navigator.of(context).pushReplacementNamed('/prePage');},
                    child: SizedBox(
                      width: 500,
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Warehouse1234'),
                        ]
                      ),
                    ),
                  ),
                ),
                
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {Navigator.of(context).pushReplacementNamed('/prePage');},
                    child: SizedBox(
                      width: 500,
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Warehouse12345'),
                        ]
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {Navigator.of(context).pushReplacementNamed('/prePage');},
                    child: SizedBox(
                      width: 500,
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Warehouse123456'),
                        ]
                      ),
                    ),
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}