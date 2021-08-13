import 'dart:convert';

ReadProductId idProductFromJson(String str) => ReadProductId.fromJson(json.decode(str));

String idProductToJson(ReadProductId data) => json.encode(data.toJson());

class ReadProductId {
  ReadProductId({
    this.message,
    this.data,
  });

  String? message;
  DataProductId? data;

  factory ReadProductId.fromJson(Map<String, dynamic> json) => ReadProductId(
        message: json["message"],
        data: DataProductId.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class DataProductId {
  DataProductId({
    this.productId,
    this.productTypeId,
    this.imageUrl,
    this.productName,
    this.singlePrice,
    this.softDelete,
  });

  int? productId;
  int? productTypeId;
  String? imageUrl;
  String? productName;
  int? singlePrice;
  bool? softDelete;

  factory DataProductId.fromJson(Map<String, dynamic> json) => DataProductId(
        productId: json["Product_ID"],
        productTypeId: json["Product_Type_ID"],
        imageUrl: json["Image_Url"],
        productName: json["Product_Name"],
        singlePrice: json["Single_Price"],
        softDelete: json["Soft_Delete"],
      );

  Map<String, dynamic> toJson() => {
        "Product_ID": productId,
        "Product_Type_ID": productTypeId,
        "Image_Url": imageUrl,
        "Product_Name": productName,
        "Single_Price": singlePrice,
        "Soft_Delete": softDelete,
      };
}