// ignore_for_file: unnecessary_new

class UpdateCartModel {
  bool? status;
  String? message;
  UpdateData? data;

  UpdateCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UpdateData.fromJson(json['data']) : null;
  }
}

class UpdateData {
  UpdateCart? cart;
  dynamic subTotal;
  dynamic total;

  UpdateData.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? UpdateCart.fromJson(json['cart']) : null;
    subTotal = json['sub_total'];
    total = json['total'];
  }
}

class UpdateCart {
  int? id;
  dynamic quantity;
  CartProduct? product;

  UpdateCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
        json['product'] != null ? CartProduct.fromJson(json['product']) : null;
  }
}

class CartProduct {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;

  CartProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}
