import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meta/meta.dart';
import 'package:warehouse_application/blocs/createProduct_bloc/createproduct_bloc.dart';
import 'package:warehouse_application/blocs/dropdown_role_bloc/dropdown_role_bloc.dart';
import 'package:warehouse_application/blocs/productType_bloc/producttype_bloc.dart';
import 'package:warehouse_application/models/productType_models.dart';
import 'package:warehouse_application/repo/repositories/createProduct_repository.dart';
import 'package:warehouse_application/repo/repositories/productTypeApi_repository.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key, required CreateProductRepository createProductRepository})
      : _createProductRepository = createProductRepository ,super(key: key);
  
  final CreateProductRepository _createProductRepository;

  @override
  _AddProductPage createState() => _AddProductPage();
}

class _AddProductPage extends State<AddProductPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();
  late CreateproductBloc _createproductBloc;
  String? type;

  @override
  void initState() {
    _createproductBloc = CreateproductBloc(createProductRepository: widget._createProductRepository);
    super.initState();
  }

  ProductTypeRepository productTypeRepository = ProductTypeRepository();
  CreateProductRepository createProductRepository = CreateProductRepository();

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

      body: FormBuilder(
        key: _formKey,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<CreateproductBloc>(
              create: (BuildContext context) =>
                CreateproductBloc(createProductRepository: createProductRepository),
            ),
            BlocProvider<ProducttypeBloc>(
              create: (BuildContext context) =>
                ProducttypeBloc(productTypeRepository: productTypeRepository),
            )
          ],
          child: SingleChildScrollView(
            child: Column(
              children: [
                _title(),
                _image(),
                _dropdownType(),
                _namaBarang(),
                _hargaBarang(),
                // _namaWarehouse(),
                // _alamatWarehouse(),
                _addProductButton()
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _title() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 15.0, 180.0, 15.0),
      child: Text("Add Product",
        style: TextStyle(
          fontSize: 30,
          fontStyle: FontStyle.italic,
          color: Colors.black
        )
      ),
    );
  }

  Widget _image() {
    return SizedBox(
      height: 150,
      width: 150,
      child: Image.network(''),
    );
  }

  Widget _dropdownType() {
    return BlocBuilder<ProducttypeBloc, ProducttypeState>(
      builder: (context, state) {
      if (state is ProducttypeLoading) {
        return Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      } else if (state is ProducttypeFailed) {
        print('Get Product Type error');
      } else if (state is ProducttypeDone) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: FormBuilderDropdown(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            hint: Text(
              'Select Product Type',
            ),
            name: 'type',
            items: state.type.map((ProductType item) {
              return DropdownMenuItem(
                child: Text('${item.productTypeName}'),
                value: item.productTypeId,
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                // if (newValue == 1) {
                //   type = 'Drug & Healthcare' ;
                // } else if (newValue == 2) {
                //   type = 'Food & Groceries';
                // } else if (newValue == 3) {
                //   type = 'Electronics';
                // } else if (newValue == 4) {
                //   type = 'Furniture & Houseware';
                // }
                type = newValue as String?;
              });
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
          ));
      }
      return Container();
    });
  }
  Widget _namaBarang() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        name: 'namaB',
        decoration: InputDecoration(
          border: OutlineInputBorder(), 
          labelText: 'Nama Barang'
        ),
        textInputAction: TextInputAction.next,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
        ]),
      )
    );
  }
  Widget _hargaBarang() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        name: 'harga',
        decoration: InputDecoration(
          border: OutlineInputBorder(), 
          labelText: 'Harga Barang'
        ),
        textInputAction: TextInputAction.next,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
          FormBuilderValidators.numeric(context)
        ]),
      )
    );
  }
  Widget _namaWarehouse() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        name: 'namaW',
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Nama Warehouse',
        ),
        textInputAction: TextInputAction.next,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
        ]),
      ),
    );
  }
  Widget _alamatWarehouse() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        name: 'alamatW',
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Alamat Warehouse',
        ),
        textInputAction: TextInputAction.next,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
        ]),
      ),
    );
  }
  Widget _addProductButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.saveAndValidate()) {
            _createproductBloc.add(CreateProductReq(
              productName: _formKey.currentState!.value['namaB'],
              productTypeId: _formKey.currentState!.value['type'],
              price: _formKey.currentState!.value['harga'],
              imageType: _formKey.currentState!.value[''],
              image64: _formKey.currentState!.value[''],
            ));
          }
          // Navigator.of(context).pushReplacementNamed('/viewListStckPage');
        },
        child: Text(
          "Add Product",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}