import 'gift_card_response.dart';

class MyGiftCardResponseModel {
  String sId;
  String status;
  int totalAmount;
  int amountUsed;
  GiftCardResponseModel giftCard;

  MyGiftCardResponseModel(
      {this.sId,
      this.status,
      this.totalAmount,
      this.amountUsed,
      this.giftCard});

  MyGiftCardResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    totalAmount = json['total_amount'];
    amountUsed = json['amount_used'];
    giftCard = json['gift_card'] != null
        ? new GiftCardResponseModel.fromJson(json['gift_card'])
        : null;
  }
}
