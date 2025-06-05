class ProductResponse {
  ProductResponse({
      this.product,});

  ProductResponse.fromJson(dynamic json) {
    if (json != null) {
      product = [];
      json.forEach((v) {
        product?.add(Product.fromJson(v));
      });
    }
  }
  List<Product>? product;



}

class Product {
  Product({
      this.toolPostID, 
      this.toolName, 
      this.price, 
      this.isFree, 
      this.imageUrl, 
      this.doctorName,});

  Product.fromJson(dynamic json) {
    toolPostID = json['toolPostID'];
    toolName = json['toolName'];
    price = json['price'];
    isFree = json['isFree'];
    imageUrl = json['imageUrl'];
    doctorName = json['doctorName'];
  }
  num? toolPostID;
  String? toolName;
  dynamic price;
  bool? isFree;
  String? imageUrl;
  String? doctorName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['toolPostID'] = toolPostID;
    map['toolName'] = toolName;
    map['price'] = price;
    map['isFree'] = isFree;
    map['imageUrl'] = imageUrl;
    map['doctorName'] = doctorName;
    return map;
  }

}