class CheckoutResponseModel {
  int itemCount;
  String sId;
  int markedPrice;
  int sellingPrice;
  int deliveryCharge;
  String name;
  String slug;
  String image;

  CheckoutResponseModel({
    this.itemCount = 1,
    this.sId,
    this.image,
    this.markedPrice = 200,
    this.name,
    this.sellingPrice,
    this.deliveryCharge,
    this.slug,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemCount'] = this.itemCount;
    data['sId'] = this.sId;
    data['markedPrice'] = this.markedPrice;
    data['sellingPrice'] = this.sellingPrice;
    data['deliveryCharge'] = this.deliveryCharge;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    return data;
  }

  CheckoutResponseModel.fromJson(Map<String, dynamic> json) {
    itemCount = json['itemCount'];
    sId = json['sId'];
    markedPrice = json['markedPrice'];
    sellingPrice = json['sellingPrice'];
    deliveryCharge = json['deliveryCharge'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }
}
