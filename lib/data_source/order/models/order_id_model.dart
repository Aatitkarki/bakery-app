class OrderIdModel {
  String order;

  OrderIdModel({this.order});

  OrderIdModel.fromJson(Map<String, dynamic> json) {
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    return data;
  }
}
