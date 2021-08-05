class ProductTypePack {
  final String message;
  final List<ProductType> data;

  ProductTypePack({
    required this.message, required this.data
  });

  factory ProductTypePack.fromJson(Map<String, dynamic> json) {
    List<ProductType> _temp = [];
    for (Map<String, dynamic> productType in json['data']) {
      _temp.add(ProductType.fromJson(productType));
    }
    return ProductTypePack(
      message: json['message'],
      data: _temp
    );
  }
}

class ProductType {
  final int productTypeId;
  final String productTypeName;

  ProductType({
    required this.productTypeId,
    required this.productTypeName,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) {
    return ProductType(
      productTypeId: json['Product_Type_ID'],
      productTypeName: json['Product_Type_Name'],
    );
  }
}