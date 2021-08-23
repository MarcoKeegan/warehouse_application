import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:warehouse_application/blocs/showProductById_bloc/showproductbyid_bloc.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';
import 'package:warehouse_application/repo/repositories/readProductById_repository.dart';
import 'package:warehouse_application/repo/repositories/updateProduct_repository.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/addStock_Page.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/updateProduct_Page.dart';

class DetailStockPage extends StatefulWidget {
  const DetailStockPage({Key? key, required this.productId}) : super(key: key);

  @override
  _DetailStockPage createState() => _DetailStockPage();
  final int productId;
}

class _DetailStockPage extends State<DetailStockPage> with TickerProviderStateMixin {
  WarehouseApiProvider provider = WarehouseApiProvider();
  GetProductByIdRepository getProductByIdRepository =
      GetProductByIdRepository();
  UpdateProductRepository updateProductRepository = UpdateProductRepository();

  late ShowproductbyidBloc showproductbyidBloc;

  @override
  void initState() {
    showproductbyidBloc =
        ShowproductbyidBloc(getProductByIdRepository: getProductByIdRepository);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    showproductbyidBloc.add(ShowProductByIdLoad(productId: widget.productId));
    super.didChangeDependencies();
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
              Navigator.of(context).pushReplacementNamed('/viewListStckPage');
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            )),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => showproductbyidBloc,
          child: Builder(
             builder: (context) =>
                        BlocListener<ShowproductbyidBloc, ShowproductbyidState>(
                      listener: (context, state) {
                        if (state is ShowproductbyidLoading) {
                          print('Loading...');
                          _showLoading();
                        } else if (state is ShowproductbyidDone) {
                          Navigator.of(context).pop();
                        }
                      },
            child: _detailProduct()),
        ),
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
              onPressed: () {},
              child: Text(
                "Disable Product",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      } else if (state is ShowproductbyidFailedById) {
        return AlertDialog(
            title: Text('ALERT!'),
            content: Text('ShowproductbyidFailedById'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Navigator.of(context).pop(context);
                    },
                    child: Text('No'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      
                    },
                    child: Text('Yes'),
                  ),
                ],
              )
            ],
          );
        
      } else if (state is ShowproductbyidErrorParam) {
        return AlertDialog(
            title: Text('ALERT!'),
            content: Text('ShowproductbyidErrorParam'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Navigator.of(context).pop(context);
                    },
                    child: Text('No'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      
                    },
                    child: Text('Yes'),
                  ),
                ],
              )
            ],
          );

      } else if (state is ShowproductbyidErrorContentType) {
        return AlertDialog(
            title: Text('ALERT!'),
            content: Text('ShowproductbyidErrorContentType'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Navigator.of(context).pop(context);
                    },
                    child: Text('No'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      
                    },
                    child: Text('Yes'),
                  ),
                ],
              )
            ],
          );

      }else if (state is ShowproductbyidErrorInternalServer) {
        return AlertDialog(
            title: Text('ALERT!'),
            content: Text('ShowproductbyidErrorInternalServer'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Navigator.of(context).pop(context);
                    },
                    child: Text('No'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      
                    },
                    child: Text('Yes'),
                  ),
                ],
              )
            ],
          );

      } else {
        return Container();
      }
    });
  }
}
