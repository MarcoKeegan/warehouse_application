class CreateProduct {
  final int productTypeId;
  final String productName;
  final String price;
  // final List<ImageProduct> images;
  final String imageType;
  final String image64;

  const CreateProduct(
      {required this.productTypeId,
      required this.productName,
      required this.price,
      required this.imageType,
      required this.image64});

  Map<String, dynamic> toJson() {
    return {
      'Product_Type_ID': productTypeId,
      'Product_Name': productName,
      'Single_Price': price,
      'mime': imageType,
      'data': image64,
    };
  }
}
