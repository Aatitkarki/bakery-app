class GiftCardBuyRequestModel {
  String giftCard;

  GiftCardBuyRequestModel({this.giftCard});

  GiftCardBuyRequestModel.fromJson(Map<String, dynamic> json) {
    giftCard = json['gift_card'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gift_card'] = this.giftCard;
    return data;
  }
}
