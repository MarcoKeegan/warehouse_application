class CreateProduct {
  final int productTypeId;
  final String productName;
  final String price;
  final ImageProduct? images;
  // final String imageType;
  // final String image64;

  const CreateProduct({
    required this.productTypeId,
    required this.productName,
    required this.price,
    this.images,
    // required this.imageType,
    // required this.image64
  });

  Map<String, dynamic> toJson() {
    if (images != null) {
      return {
      'Product_Type_ID': productTypeId,
      'Product_Name': productName,
      'Single_Price': price,
      'Image': images,
      // 'mime': imageType,
      // 'data': image64,
    };
    } else {
      return {
      'Product_Type_ID': productTypeId,
      'Product_Name': productName,
      'Single_Price': price,
    };
    }
  }
}

class ImageProduct {
  final String? imageType;
  final String? image64;

  const ImageProduct({
    required this.imageType,
    required this.image64,
  });

  Map<String, dynamic> toJson() {
    return {
      'mime': imageType,
      'data': image64,
    };
  }
}
