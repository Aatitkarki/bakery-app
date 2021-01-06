class OrderRequestModel {
  List<String> foods;
  List<int> quantity;
  String addressNote;
  String phone;
  String deliveryDistanceId;

  OrderRequestModel(
      {this.foods,
      this.quantity,
      this.addressNote,
      this.phone,
      this.deliveryDistanceId});

  OrderRequestModel.fromJson(Map<String, dynamic> json) {
    foods = json['foods'].cast<String>();
    quantity = json['quantity'].cast<int>();
    addressNote = json['address_note'];
    phone = json['phone'];
    deliveryDistanceId = json['delivery_distance_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foods'] = this.foods;
    data['quantity'] = this.quantity;
    data['address_note'] = this.addressNote;
    data['phone'] = this.phone;
    data['delivery_distance_id'] = this.deliveryDistanceId;
    return data;
  }
}
