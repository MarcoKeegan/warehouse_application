import 'package:flutter/material.dart';

class ListStockPage extends StatefulWidget {
  const ListStockPage({Key? key}) : super(key: key);
  @override
  _ListStockPage createState() => _ListStockPage();
}

class _ListStockPage extends State<ListStockPage> {
  // List<dynamic> product = [
  //   "Android Cupcake",
  //   "Android Donut",
  //   "Android Eclair",
  //   "Android Froyo",
  //   "Android Gingerbread",
  //   "Android Honeycomb",
  //   "Android Ice Cream Sandwich",
  //   "Android Jelly Bean",
  //   "Android Kitkat",
  //   "Android Lollipop",
  //   "Android Marshmallow",
  //   "Android Nougat",
  //   "Android Oreo",
  //   "Android Pie"
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[400],
        centerTitle: true,
        title: Text(
          'Warehouse',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/dashM');
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 15.0, 180.0, 15.0),
              child: Text("List Product",
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.black)),
            ),
            Container(
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 200.0,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: product.length,
                  //     itemBuilder: (context, index) {
                  //       return Card(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10)),
                  //         elevation: 2,
                  //         child: InkWell(
                  //           onTap: () {
                  //             // Navigator.of(context)
                  //             //     .pushReplacementNamed('/detailStockPage');
                  //           },
                  //           child: SizedBox(
                  //             width: 500,
                  //             height: 80,
                  //             child: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Text(product[index]),
                  //                   // Text('Rp 25.000,00'),
                  //                 ]),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),

                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/detailStockPage');
                      },
                      child: SizedBox(
                        width: 500,
                        height: 80,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Product 1'),
                              Text('Rp 25.000,00'),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Product',
        backgroundColor: Colors.cyan[400],
        child: Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/addStckPage');
        },
      ),
    );
  }
}
