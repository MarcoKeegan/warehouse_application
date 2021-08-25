import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:warehouse_application/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:warehouse_application/blocs/deleteProduct_bloc/deleteproduct_bloc.dart';
import 'package:warehouse_application/blocs/showProductById_bloc/showproductbyid_bloc.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';
import 'package:warehouse_application/repo/repositories/deleteProduct_repository.dart';
import 'package:warehouse_application/repo/repositories/readProductById_repository.dart';
import 'package:warehouse_application/repo/repositories/updateProduct_repository.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/addStock_Page.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/updateProduct_Page.dart';

class DetailStockPage extends StatefulWidget {
  const DetailStockPage({Key? key, required this.productId, required DeleteProductRepository deleteProductRepository}) 
      : _deleteProductRepository = deleteProductRepository, super(key: key);

  @override
  _DetailStockPage createState() => _DetailStockPage();
  final int productId;
  final DeleteProductRepository _deleteProductRepository;
}

class _DetailStockPage extends State<DetailStockPage>
    with TickerProviderStateMixin {
  WarehouseApiProvider provider = WarehouseApiProvider();
  GetProductByIdRepository getProductByIdRepository =
      GetProductByIdRepository();
  UpdateProductRepository updateProductRepository = UpdateProductRepository();
  // DeleteProductRepository deleteProductRepository = DeleteProductRepository();

  late ShowproductbyidBloc showproductbyidBloc;
  late DeleteproductBloc _deleteproductBloc;

  @override
  void initState() {
    showproductbyidBloc =
        ShowproductbyidBloc(getProductByIdRepository: getProductByIdRepository);
    _deleteproductBloc = DeleteproductBloc(deleteProductRepository: widget._deleteProductRepository);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    showproductbyidBloc.add(ShowProductByIdLoad(productId: widget.productId));
    super.didChangeDependencies();
  }

  Future<void> _showSnackbar() async {
    final snackBar = SnackBar(
      content: const Text('Disable Product Succes!'),
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
                // Navigator.of(context).pushReplacementNamed('/viewListStckPage');
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                size: 30,
              )),
        ),
        body: SingleChildScrollView(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<ShowproductbyidBloc>(create: (context) => showproductbyidBloc,),
              BlocProvider<DeleteproductBloc>(create: (context) => _deleteproductBloc),
            ],
            child: MultiBlocListener(
              listeners: [
                BlocListener<ShowproductbyidBloc, ShowproductbyidState>(
                        listener: (context, state) {
                          if (state is ShowproductbyidLoading) {
                            print('Loading...');
                            _showLoading();
                          } else if (state is ShowproductbyidDone) {
                            Navigator.of(context).pop();
                          } else if (state is ShowproductbyidFailedById) {
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
                          } else if (state is ShowproductbyidErrorParam) {
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
                          } else if (state is ShowproductbyidErrorContentType) {
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
                          } else if (state
                              is ShowproductbyidErrorInternalServer) {
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
                          }
                        },
                       ),
              BlocListener<DeleteproductBloc, DeleteproductState>(
                    listener: (context, state) {
                  if (state is DeleteProductDone) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/viewListStckPage');
                    _showSnackbar();
                  // } else if (state is DeleteProductLoading) {
                  //   print('Disable Loading...');
                  //   _showLoading();
                  // } else if (state is DeleteProductFailedInvalidProductId) {
                  //     Navigator.of(context).pop();
                  //     showDialog(
                  //         context: context,
                  //         builder: (builder) {
                  //           return AlertDialog(
                  //             title: Text('ALERT!'),
                  //             content: Text(
                  //                 'Something went wrong with product id, please try another product.'),
                  //             actions: [
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.end,
                  //                 children: [
                  //                   OutlinedButton(
                  //                     onPressed: () {
                  //                       Navigator.of(context).pop();
                  //                     },
                  //                     child: Text('OK'),
                  //                   ),
                  //                 ],
                  //               )
                  //             ],
                  //           );
                  //         });
                  // } else if (state is DeleteProductErrorInternalServer) {
                  //     Navigator.of(context).pop();
                  //     showDialog(
                  //         context: context,
                  //         builder: (builder) {
                  //           return AlertDialog(
                  //             title: Text('ALERT!'),
                  //             content: Text(
                  //                 'Something went wrong on our server, please try again later.'),
                  //             actions: [
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.end,
                  //                 children: [
                  //                   OutlinedButton(
                  //                     onPressed: () {
                  //                       Navigator.of(context).pop();
                  //                     },
                  //                     child: Text('OK'),
                  //                   ),
                  //                 ],
                  //               )
                  //             ],
                  //           );
                  //         });
                  // } else if (state is DeleteProductFailedInvalidUid) {
                  //     Navigator.of(context).pop();
                  //     showDialog(
                  //         context: context,
                  //         builder: (builder) {
                  //           return AlertDialog(
                  //             title: Text('ALERT!'),
                  //             content: Text(
                  //                 'This account has not authority for this page.'),
                  //             actions: [
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.end,
                  //                 children: [
                  //                   OutlinedButton(
                  //                     onPressed: () {
                  //                       Navigator.of(context).pop();
                  //                     },
                  //                     child: Text('OK'),
                  //                   ),
                  //                 ],
                  //               )
                  //             ],
                  //           );
                  //         });
                  }
                })
            ],  child: _detailProduct())   
          ),
        ));
  }

  Widget _detailProduct() {
    return BlocBuilder<ShowproductbyidBloc, ShowproductbyidState>(
        builder: (context, state) {
      if (state is ShowproductbyidDone) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 15.0, 160.0, 15.0),
              child: Text("Detail Product",
                  style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.black)),
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: Image.network('${state.productID.data!.imageUrl}'),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 2,
              child: InkWell(
                child: SizedBox(
                  width: 500,
                  height: 60,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Product ID : '),
                        Text('${state.productID.data!.productId}'),
                      ]),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 2,
              child: InkWell(
                child: SizedBox(
                  width: 500,
                  height: 60,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Product Name : '),
                        Text('${state.productID.data!.productName}'),
                      ]),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 2,
              child: InkWell(
                child: SizedBox(
                  width: 500,
                  height: 60,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Product Type : '),
                        Text('${state.productID.data!.productTypeName}'),
                      ]),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 2,
              child: InkWell(
                child: SizedBox(
                  width: 500,
                  height: 60,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Harga Product : '),
                        Text('${state.productID.data!.singlePrice}'),
                      ]),
                ),
              ),
            ),
            // Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       width: 500.0,
            //       height: 50.0,
            //       decoration:
            //           BoxDecoration(border: Border.all(color: Colors.black)),
            //       child: Text(
            //         '${state.productID.data!.productName}',
            //         textAlign: TextAlign.center,
            //       ),
            //     )),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddStockPage()),
                );
              },
              child: Text(
                "Add Stock",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateProductPage(
                            productId: state.productID.data!.productId!,
                            updateProductRepository: updateProductRepository,
                          )),
                );
              },
              child: Text(
                "Edit Product",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (builder) {
                    return AlertDialog(
                      title: Text('ALERT!'),
                      content: Text(
                          'Are you sure want to disable this product?'),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('No'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                _deleteproductBloc.add(DisableProduct(
                                  firebaseUid: BlocProvider.of<AuthenticationBloc>(context)
                                                  .user
                                                  .uid,
                                  productId: widget.productId,
                                  ));
                              
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        )
                      ],
                    );
                  });
              },
              child: Text(
                "Disable Product",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}





