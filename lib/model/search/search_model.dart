// ignore_for_file: unnecessary_new

class SearchModel {
  bool? status;
  SearchData? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new SearchData.fromJson(json['data']) : null;
  }
}

class SearchData {
  List<SearchProductModel> products = [];
  dynamic total;
  SearchData.fromJson(Map<String, dynamic> json) {
    products = List.from(json["data"])
        .map((e) => SearchProductModel.fromJson(e))
        .toList();
    total = json["total"];
  }
}

class SearchProductModel {
  int? id;
  dynamic price;
  String? image;
  List<String> images = [];
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  SearchProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    name = json['name'];
    image = json['image'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    description = json['description'];
  }
}
