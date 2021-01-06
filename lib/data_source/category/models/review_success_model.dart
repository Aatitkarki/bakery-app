import 'package:bakery/data_source/category/models/food_review_response.dart';

class ReviewSuccessModel {
  String sId;
  double rating;
  String review;
  FoodReviewResponseModel food;
  ReviewUserResponseModel customer;
  String createdAt;
  String updatedAt;
  int iV;

  ReviewSuccessModel(
      {this.sId,
      this.rating,
      this.review,
      this.food,
      this.customer,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ReviewSuccessModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rating = (json['rating'] ?? 0).toDouble();
    review = json['review'];
    food = json['food'] != null
        ? new FoodReviewResponseModel.fromJson(json['food'])
        : null;
    customer = json['customer'] != null
        ? new ReviewUserResponseModel.fromJson(json['customer'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['rating'] = this.rating;
    data['review'] = this.review;
    if (this.food != null) {
      data['food'] = this.food.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ReviewUserResponseModel {
  String sId;
  String name;
  String image;

  ReviewUserResponseModel({this.sId, this.name, this.image});

  ReviewUserResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
