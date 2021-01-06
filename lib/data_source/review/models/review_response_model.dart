import 'package:bakery/data_source/review/models/review_model.dart';

class ReviewResponseModel {
  String message;
  ReviewModel payload;

  ReviewResponseModel({this.message, this.payload});

  ReviewResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    payload = json['payload'] != null
        ? new ReviewModel.fromJson(json['payload'])
        : null;
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
