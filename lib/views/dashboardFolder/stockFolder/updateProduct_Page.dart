import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:warehouse_application/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:warehouse_application/blocs/productType_bloc/producttype_bloc.dart';
import 'package:warehouse_application/blocs/showProductById_bloc/showproductbyid_bloc.dart';
import 'package:warehouse_application/blocs/updateProduct_bloc/updateproduct_bloc.dart';
import 'package:warehouse_application/models/productType_models.dart';
import 'package:warehouse_application/repo/repositories/productTypeApi_repository.dart';
import 'package:warehouse_application/repo/repositories/readProductById_repository.dart';
import 'package:warehouse_application/repo/repositories/updateProduct_repository.dart';

class UpdateProductPage extends StatefulWidget {
  const UpdateProductPage(
      {Key? key,
      required this.productId,
      required UpdateProductRepository updateProductRepository})
      : _updateProductRepository = updateProductRepository,
        super(key: key);

  @override
  _UpdateProductPage createState() => _UpdateProductPage();
  final UpdateProductRepository _updateProductRepository;
  final int productId;
}

class _UpdateProductPage extends State<UpdateProductPage>
    with TickerProviderStateMixin {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey();
  late UpdateproductBloc _updateproductBloc;
  String? type;
  ProductTypeRepository productTypeRepository = ProductTypeRepository();
  GetProductByIdRepository getProductByIdRepository =
      GetProductByIdRepository();
  UpdateProductRepository updateProductRepository = UpdateProductRepository();

  late ShowproductbyidBloc showproductbyidBloc;

  @override
  void didChangeDependencies() {
    showproductbyidBloc.add(ShowProductByIdLoad(productId: widget.productId));
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _updateproductBloc = UpdateproductBloc(
        updateProductRepository: widget._updateProductRepository);
    showproductbyidBloc =
        ShowproductbyidBloc(getProductByIdRepository: getProductByIdRepository);
    super.initState();
  }

  Future<void> _showSnackbar() async {
    final snackBar = SnackBar(
      content: const Text('Update Product Succes!'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _showLoading() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SpinKitFadingCircle(
            color: Colors.cyan[400],
            size: 50,
            controller: AnimationController(
                vsync: this, duration: const Duration(milliseconds: 2000)),
          );
        });
  }

  Future<void> _showAlertDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ALERT!'),
            content: Text('Are you sure to save this changes?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(context),
                    child: Text('No'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        //untuk cek type data
                        // print(_formKey.currentState!.value['type'].runtimeType);
                        // print(_formKey.currentState!.value['harga'].runtimeType);
                        // print(_formKey.currentState!.value['namaB'].runtimeType);
                        // print(_formKey.currentState!.value['image'].runtimeType);

                        _updateproductBloc.add(UpdateProductReq(
                          productName: _formKey.currentState!.value['namaB'],
                          productTypeId: _formKey.currentState!.value['type'],
                          price: _formKey.currentState!.value['harga'],
                          image64: _formKey.currentState!.value['image'] != null
                              ? (_formKey.currentState!.value['image']
                                      as List<PlatformFile>)
                                  .first
                                  .bytes!
                              : null,
                          imageType:
                              _formKey.currentState!.value['image'] != null
                                  ? (_formKey.currentState!.value['image']
                                          as List<PlatformFile>)
                                      .first
                                      .extension!
                                  : null,
                          firebaseUid:
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .user
                                  .uid,
                          productId: widget.productId,
                        ));
                        // Navigator.of(context)
                        //     .pushReplacementNamed('/viewListStckPage');
                        // _showSnackbar();
                      } else {
                        Navigator.of(context).pop(context);
                      }
                    },
                    child: Text('Yes'),
                  ),
                ],
              )
            ],
          );
        });
  }

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
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 30,
              )),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: MultiBlocProvider(
              providers: [
                BlocProvider<UpdateproductBloc>(
                  create: (BuildContext context) => _updateproductBloc,
                ),
                BlocProvider<ProducttypeBloc>(
                  create: (BuildContext context) => ProducttypeBloc(
                      productTypeRepository: productTypeRepository),
                ),
                BlocProvider(create: (context) => showproductbyidBloc),
              ],
              child: SingleChildScrollView(
                child: Builder(
                  builder: (context) =>
                      BlocListener<UpdateproductBloc, UpdateproductState>(
                    listener: (context, state) {
                      if (state is UpdateproductLoading) {
                        print('Loading...');
                        _showLoading();
                      } else if (state is UpdateproductDone) {
                        Navigator.of(context).pop();
                        Navigator.of(context)
                            .pushReplacementNamed('/viewListStckPage');
                        _showSnackbar();
                      } else if (state is UpdateproductInvalidProductId) {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return AlertDialog(
                                title: Text('ALERT!'),
                                content: Text(
                                    'Something went wrong with product id, please try another product.'),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            });
                      } else if (state is UpdateproductErrorParam) {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return AlertDialog(
                                title: Text('ALERT!'),
                                content: Text(
                                    'Something went wrong, please try again later.'),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            });
                      } else if (state is UpdateproductContentType) {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return AlertDialog(
                                title: Text('ALERT!'),
                                content: Text(
                                    'Something went wrong with this content, please try again later.'),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            });
                      } else if (state is UpdateproductInternalServer) {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return AlertDialog(
                                title: Text('ALERT!'),
                                content: Text(
                                    'Something went wrong on our server, please try again later.'),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            });
                      } else if (state is UpdateproductInvalidUid) {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return AlertDialog(
                                title: Text('ALERT!'),
                                content: Text(
                                    'This account has not authority for this page.'),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            });
                      }
                    },
                    child: Column(
                      children: [
                        _title(),
                        // _image(),
                        _uploadImage(),
                        BlocBuilder<ShowproductbyidBloc, ShowproductbyidState>(
                          builder: (context, state) {
                            if (state is ShowproductbyidDone) {
                              return _dropdownType(
                                  state.productID.data!.productTypeId!);
                            }
                            return Container();
                          },
                        ),
                        _namaBarang(context),
                        _hargaBarang(context),
                        // _namaWarehouse(),
                        // _alamatWarehouse(),
                        _addProductButton(),
                        // new Align(child: loadingIndicator,alignment: FractionalOffset.center,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )));
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 15.0, 180.0, 15.0),
      child: Text("Edit Product",
          style: TextStyle(
              fontSize: 30, fontStyle: FontStyle.italic, color: Colors.black)),
    );
  }

  Widget _dropdownType(int initialValue) {
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
                labelText: 'Product Type',
                border: OutlineInputBorder(),
              ),
              hint: BlocBuilder<ShowproductbyidBloc, ShowproductbyidState>(
                builder: (context, state) {
                  if (state is ShowproductbyidDone) {
                    return Text(
                      '${state.productID.data!.productTypeName}',
                    );
                  }
                  return Container();
                },
              ),
              initialValue: initialValue,
              name: 'type',
              items: state.type.map((ProductType item) {
                return DropdownMenuItem(
                  child: Text('${item.productTypeName}'),
                  value: item.productTypeId,
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  if (newValue == 1) {
                    type = 'Drug & Healthcare';
                  } else if (newValue == 2) {
                    type = 'Food & Groceries';
                  } else if (newValue == 3) {
                    type = 'Electronics';
                  } else if (newValue == 4) {
                    type = 'Furniture & Houseware';
                  }
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

  Widget _namaBarang(BuildContext context) {
    return BlocBuilder<ShowproductbyidBloc, ShowproductbyidState>(
      builder: (context, state) {
        if (state is ShowproductbyidDone) {
          return Padding(
              padding: EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                initialValue: '${state.productID.data!.productName}',
                name: 'namaB',
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  // hintText: '${state.productID.data!.productName}',
                  labelText: 'Nama Barang',
                ),
                textInputAction: TextInputAction.next,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
              ));
        }
        return Container();
      },
    );
  }

  Widget _hargaBarang(BuildContext context) {
    return BlocBuilder<ShowproductbyidBloc, ShowproductbyidState>(
      builder: (context, state) {
        if (state is ShowproductbyidDone) {
          return Padding(
              padding: EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                initialValue: '${state.productID.data!.singlePrice}',
                name: 'harga',
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Harga Barang',
                  // hintText: '${state.productID.data!.singlePrice}'
                ),
                textInputAction: TextInputAction.next,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.numeric(context)
                ]),
              ));
        }
        return Container();
      },
    );
  }

  // Widget _image() {
  //   return BlocBuilder<ShowproductbyidBloc, ShowproductbyidState>(
  //       builder: (context, state) {
  //     if (state is ShowproductbyidDone) {
  //       return SizedBox(
  //         width: 150,
  //         height: 150,
  //         child: Image.network('${state.productID.data!.imageUrl}'),
  //       );
  //     }
  //     return Container();
  //   });
  // }

  Widget _uploadImage() {
    return BlocBuilder<ShowproductbyidBloc, ShowproductbyidState>(
        builder: (context, state) {
      if (state is ShowproductbyidDone) {
        return Column(children: [
          _formKey.currentState?.value['image'] == null
              ? Image.network(
                  state.productID.data!.imageUrl!,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderFilePicker(
              name: 'image',
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Upload New Image',
              ),
              maxFiles: 1,
              withData: true,
              // key: _formKey,
              previewImages: true,
              selector: Icon(Icons.upload),
              onFileLoading: (val) {
                print('val');
              },

              // validator: FormBuilderValidators.compose([
              //   FormBuilderValidators.required(context),
              // ]),
            ),
          ),
        ]);
      }
      return Container();
    });
  }

  Widget _addProductButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          _showAlertDialog();
        },
        child: Text(
          "Edit Product",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
