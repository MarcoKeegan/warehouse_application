import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({Key? key}) : super(key: key);

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
              Navigator.of(context).pushReplacementNamed('/viewListStckPage');
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
              child: Text("Add Product",
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.black)),
            ),
            SizedBox(
              height: 150,
              width: 150,
              child: Image.network(''),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'tipe',
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Tipe Barang'),
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                )),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'namaB',
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Nama Barang'),
                )),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: FormBuilderTextField(
                  name: 'harga',
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Harga Barang'),
                )),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'namaW',
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Warehouse',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: 'alamatW',
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Alamat Warehouse',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pushReplacementNamed('/viewListStckPage');
              },
              child: Text(
                "Add Product",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
