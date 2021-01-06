class OrderSuccessModel {
  String message;
  Payload payload;

  OrderSuccessModel({this.message, this.payload});

  OrderSuccessModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    payload =
        json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.payload != null) {
      data['payload'] = this.payload.toJson();
    }
    return data;
  }
}

class Payload {
  List<String> foods;
  String sId;
  String customer;
  String addressNote;
  String priceDuringOrder;
  String deliveryCharge;
  String status;
  String createdAt;
  String updatedAt;
  int iV;

  Payload(
      {this.foods,
      this.sId,
      this.customer,
      this.addressNote,
      this.priceDuringOrder,
      this.deliveryCharge,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Payload.fromJson(Map<String, dynamic> json) {
    foods = json['foods'].cast<String>();
    sId = json['_id'];
    customer = json['customer'];
    addressNote = json['address_note'];
    priceDuringOrder = json['price_during_order'];
    deliveryCharge = json['delivery_charge'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foods'] = this.foods;
    data['_id'] = this.sId;
    data['customer'] = this.customer;
    data['address_note'] = this.addressNote;
    data['price_during_order'] = this.priceDuringOrder;
    data['delivery_charge'] = this.deliveryCharge;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
