import 'package:bakery/data_source/category/models/review_success_model.dart';
import 'package:bakery/data_source/food/models/food_item_slug_response.dart';

class CategoryItemSlugResponseModel {
  String sId;
  List<String> images;
  int views;
  String name;
  String slug;
  String tagline;
  String createdAt;
  String updatedAt;
  int iV;
  List<FoodItemSlugResponseModel> foods;
  List<ReviewSuccessModel> reviews;
  double averageRating;

  CategoryItemSlugResponseModel(
      {this.sId,
      this.images,
      this.views,
      this.name,
      this.slug,
      this.tagline,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.foods,
      this.reviews,
      this.averageRating});

  CategoryItemSlugResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    images = json['images'].cast<String>();
    views = json['views'];
    name = json['name'];
    slug = json['slug'];
    tagline = json['tagline'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    if (json['foods'] != null) {
      foods = new List<FoodItemSlugResponseModel>();
      json['foods'].forEach((v) {
        foods.add(new FoodItemSlugResponseModel.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = new List<ReviewSuccessModel>();
      json['reviews'].forEach((v) {
        reviews.add(new ReviewSuccessModel.fromJson(v));
      });
    }
    averageRating = (json['average_rating'] ?? 0).toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['images'] = this.images;
    data['views'] = this.views;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['tagline'] = this.tagline;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.foods != null) {
      data['foods'] = this.foods.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    data['average_rating'] = this.averageRating;
    return data;
  }
}
