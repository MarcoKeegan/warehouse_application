import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_application/blocs/showProduct_bloc/show_product_bloc.dart';
import 'package:warehouse_application/repo/provider/warehouseApi_Provider.dart';
import 'package:warehouse_application/repo/repositories/readProduct_repository.dart';
import 'package:warehouse_application/views/dashboardFolder/stockFolder/detailStock_Page.dart';

class ListStockPage extends StatefulWidget {
  const ListStockPage({Key? key}) : super(key: key);
  @override
  _ListStockPage createState() => _ListStockPage();
}

class _ListStockPage extends State<ListStockPage> {
  WarehouseApiProvider warehouseApiProvider = WarehouseApiProvider();
  GetProductRepository getProductRepository = GetProductRepository();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: BlocProvider(
        create: (context) =>
            ShowProductBloc(getProductRepository: getProductRepository),
        child: SingleChildScrollView(
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
                    Container(height: size.height * 0.9, child: _listProduct())
                  ],
                ),
              ),
            ],
          ),
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

  Widget _listProduct() {
    return BlocBuilder<ShowProductBloc, ShowProductState>(
        builder: (context, state) {
      if (state is ShowProductLoading) {
        CircularProgressIndicator(color: Colors.white);
      } else if (state is ShowProductFailed) {
        print('Show Product Failed');
      } else if (state is ShowProductDone) {
        return ListView.builder(
            itemCount: state.product.data!.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailStockPage(
                            productId: state.product.data![index].productId!)));
                  },
                  child: SizedBox(
                    width: 500,
                    height: 80,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              '${state.product.data![index].productName.toString()}'),
                          Text(
                              '${state.product.data![index].price.toString()}'),
                        ]),
                  ),
                ),
              );
            });
      }
      return Container();
    });
  }
}
