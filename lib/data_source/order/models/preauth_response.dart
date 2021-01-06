class PreAuthResponseModel {
  int amount;
  String clientSecret;

  PreAuthResponseModel({this.amount, this.clientSecret});

  PreAuthResponseModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    clientSecret = json['client_secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['client_secret'] = this.clientSecret;
    return data;
  }
}
