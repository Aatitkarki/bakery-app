class GiftCardResponseModel {
  String sId;
  String image;
  int price;

  GiftCardResponseModel({this.sId, this.image, this.price});

  GiftCardResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['image'] = this.image;
    data['price'] = this.price;
    return data;
  }
}
