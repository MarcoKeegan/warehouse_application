import 'dart:convert';

ReadAllProduct allProductFromJson(String str) => ReadAllProduct.fromJson(json.decode(str));

String allProductToJson(ReadAllProduct data) => json.encode(data.toJson());

class ReadAllProduct {
  String? message;
  List<ProductData>? data;

  ReadAllProduct({
    this.message,
    this.data,
  });

  factory ReadAllProduct.fromJson(Map<String, dynamic> json) => ReadAllProduct(
        message: json["message"],
        data: List<ProductData>.from(json["data"].map((x) => ProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProductData {
  int? productId;
  int? productTypeId;
  String? imageUrl;
  String? productName;
  int? price;
  bool? softDelete;

  ProductData({
    this.productId,
    this.productTypeId,
    this.imageUrl,
    this.productName,
    this.price,
    this.softDelete,
  });
  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        productId: json["Product_ID"],
        productTypeId: json["Product_Type_ID"],
        imageUrl: json["Image_Url"] == null ? null : json["Image_Url"],
        productName: json["Product_Name"],
        price: json["Single_Price"],
        softDelete: json["Soft_Delete"],
      );

  Map<String, dynamic> toJson() => {
        "Product_ID": productId,
        "Product_Type_ID": productTypeId,
        "Image_Url": imageUrl == null ? null : imageUrl,
        "Product_Name": productName,
        "Single_Price": price,
        "Soft_Delete": softDelete,
      };
}


// class ReadAllProduct {
//   final String message;
//   final List<ProductData> data;

//   ReadAllProduct({required this.message, required this.data});

//   factory ReadAllProduct.fromJson(Map<String, dynamic> json) {
//     List<ProductData> _temp = [];
//     for (Map<String, dynamic> data in json['data']) {
//       _temp.add(ProductData.fromJson(data));
//     }
//     return ReadAllProduct(message: json['message'], data: _temp);
//   }
// }

// class ProductData {
//   final int productId;
//   final int productTypeId;
//   final String imageUrl;
//   final String productName;
//   final String singlePrice;
//   final bool softDelete;

//   ProductData({
//     required this.productId,
//     required this.productTypeId,
//     required this.imageUrl,
//     required this.productName,
//     required this.singlePrice,
//     required this.softDelete,
//   });

//   factory ProductData.fromJson(Map<String, dynamic> json) {
//     return ProductData(
//       productId: json['Product_ID'],
//       productTypeId: json['Product_Type_ID'],
//       imageUrl: json['Image_Url'],
//       productName: json['Product_Name'],
//       singlePrice: json['Single_Price'],
//       softDelete: json['Soft_Delete'],
//     );
//   }
// }

