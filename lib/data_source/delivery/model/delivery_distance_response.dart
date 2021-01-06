class DeliveryDistanceResponseModel {
  String sId;
  String name;
  int price;
  String createdAt;

  DeliveryDistanceResponseModel(
      {this.sId, this.name, this.price, this.createdAt});

  DeliveryDistanceResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    return data;
  }
}
