class ReadAllProduct {
  final String message;
  final List<ProductData> data;

  ReadAllProduct({required this.message, required this.data});

  factory ReadAllProduct.fromJson(Map<String, dynamic> json) {
    List<ProductData> _temp = [];
    for (Map<String, dynamic> data in json['data']) {
      _temp.add(ProductData.fromJson(data));
    }
    return ReadAllProduct(message: json['message'], data: _temp);
  }
}

class ProductData {
  final int productId;
  final int productTypeId;
  final String imageUrl;
  final String productName;
  final String singlePrice;
  final bool softDelete;

  ProductData({
    required this.productId,
    required this.productTypeId,
    required this.imageUrl,
    required this.productName,
    required this.singlePrice,
    required this.softDelete,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      productId: json['Product_ID'],
      productTypeId: json['Product_Type_ID'],
      imageUrl: json['Image_Url'],
      productName: json['Product_Name'],
      singlePrice: json['Single_Price'],
      softDelete: json['Soft_Delete'],
    );
  }
}
