class OrdersModel {
  bool? status;
  String? message;
  Data? data;

  OrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  List<OrdersDetails>? ordersDetails;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      ordersDetails = [];
      json['data'].forEach((v) {
        ordersDetails!.add(OrdersDetails.fromJson(v));
      });
    }
    // json['data'].forEach((value) {
    //   ordersDetails!.add(OrdersDetails.fromJson(value));
    // });
  }
}

class OrdersDetails {
  int? id;
  dynamic total;
  String? date;
  String? status;

  OrdersDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
  }
}
