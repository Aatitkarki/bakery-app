enum OrderStatus {
  PENDING_PAYMENT,
  PAID_REQUIRE_CONFIRMATION,
  PAID_CONFIRMED,
  CANCELLED,
  PAYMENT_RECEIVE_FAILED,
  COOKED,
  COMPLETED,
}

class OrderResponseModel {
  String sId;
  List<Foods> foods;
  List<int> quantity;
  String addressNote;
  String priceDuringOrder;
  String deliveryCharge;
  String status;
  Payment payment;
  bool canReview;

  OrderStatus get decodedStatus {
    switch (status) {
      case "pending_payment":
        return OrderStatus.PENDING_PAYMENT;
        break;
      case "paid_require_confirmation":
        return OrderStatus.PAID_REQUIRE_CONFIRMATION;
        break;
      case "paid_confirmed":
        return OrderStatus.PAID_CONFIRMED;
        break;
      case "cancelled":
        return OrderStatus.CANCELLED;
        break;
      case "payment_receive_failed":
        return OrderStatus.PAYMENT_RECEIVE_FAILED;
        break;
      case "cooked":
        return OrderStatus.COOKED;
        break;
      case "completed":
        return OrderStatus.COMPLETED;
        break;
    }
  }

  OrderResponseModel(
      {this.sId,
      this.foods,
      this.addressNote,
      this.priceDuringOrder,
      this.deliveryCharge,
      this.status,
      this.payment});

  OrderResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];

    quantity = json['quantity'].cast<int>();

    if (json['foods'] != null) {
      foods = new List<Foods>();

      for (int i = 0; i < json['foods'].length; i++) {
        foods.add(new Foods.fromJson(json['foods'][i], quantity[i]));
      }
    }
    addressNote = json['address_note'];
    priceDuringOrder = json['price_during_order'];
    deliveryCharge = json['delivery_charge'];
    status = json['status'];
    canReview = json['can_review'];
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.foods != null) {
      data['foods'] = this.foods.map((v) => v.toJson()).toList();
    }
    data['address_note'] = this.addressNote;
    data['price_during_order'] = this.priceDuringOrder;
    data['delivery_charge'] = this.deliveryCharge;
    data['status'] = this.status;
    data['can_review'] = this.canReview;

    if (this.payment != null) {
      data['payment'] = this.payment.toJson();
    }
    return data;
  }
}

class Foods {
  String sId;
  List<String> images;
  String name;
  String slug;
  int quantity;

  Foods({this.sId, this.images, this.name, this.slug});

  Foods.fromJson(Map<String, dynamic> json, int quantity) {
    this.quantity = quantity;

    sId = json['_id'];
    if (json['images'] != null) {
      images = json['images'].cast<String>();
    }
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['images'] = this.images;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class Payment {
  String sId;
  String status;
  String amount;

  Payment({this.sId, this.status, this.amount});

  Payment.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['amount'] = this.amount;
    return data;
  }
}
