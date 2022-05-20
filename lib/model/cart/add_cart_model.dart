class ChangeCartModel {
   bool? status;
  String? message;
  AddCartProductData? data;


  ChangeCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =json['data'] != null ?  AddCartProductData.fromJson(json['data']) : null;
  }
}

class AddCartProductData {
  int? id;
  dynamic quantity;
  CartProduct? product;


  AddCartProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =json['data'] != null ?  CartProduct.fromJson(json['product']) : null;
  }
}

class CartProduct {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;


  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}