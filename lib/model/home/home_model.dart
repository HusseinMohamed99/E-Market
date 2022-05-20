class HomeModel {
  bool? status;
  HomeDataModel? data;



  HomeModel.fromJson(Map<String,dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);

  }

}

class HomeDataModel {
  List<Banners> banners=[];
  List<ProductModel> products=[];




  HomeDataModel.fromJson(Map<String,dynamic> json)
  {
    json['banners'].forEach((element) {
      banners.add(Banners.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));    });
  }
}

class Banners {
  int? id;
  String? image;

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];

  }


}

class ProductResponse {
  bool? status;
  ProductModel? data;
  ProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = ProductModel.fromJson(json['data']);
  }
}
class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;
  String? description;
  List<String>? images;


  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    description = json['description'];
    images = json['images'].cast<String>();
  }
}
