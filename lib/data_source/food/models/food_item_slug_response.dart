import 'package:bakery/data_source/review/models/review_model.dart';

class FoodItemSlugResponseModel {
  String sId;
  int views;
  List<String> images;
  int averageRating;
  int orderCount;
  String name;
  String category;
  int markedPrice;
  int sellingPrice;
  int deliveryCharge;
  String searchTags;
  String slug;
  String createdAt;
  String updatedAt;
  List<ReviewModel> reviews;
  int iV;

  FoodItemSlugResponseModel(
      {this.sId,
      this.views,
      this.images,
      this.averageRating,
      this.orderCount,
      this.name,
      this.category,
      this.markedPrice,
      this.sellingPrice,
      this.deliveryCharge,
      this.searchTags,
      this.slug,
      this.createdAt,
      this.updatedAt,
      this.reviews,
      this.iV});

  FoodItemSlugResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    views = json['views'];
    images = json['images'].cast<String>();
    averageRating = json['average_rating'];
    orderCount = json['order_count'];
    name = json['name'];
    category = json['category'];
    markedPrice = json['marked_price'];
    sellingPrice = json['selling_price'];
    deliveryCharge = json['delivery_charge'];
    searchTags = json['search_tags'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['reviews'] != null) {
      reviews = new List<ReviewModel>();
      json['reviews'].forEach((v) {
        reviews.add(new ReviewModel.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['views'] = this.views;
    data['images'] = this.images;
    data['average_rating'] = this.averageRating;
    data['order_count'] = this.orderCount;
    data['name'] = this.name;
    data['category'] = this.category;
    data['marked_price'] = this.markedPrice;
    data['selling_price'] = this.sellingPrice;
    data['delivery_charge'] = this.deliveryCharge;
    data['search_tags'] = this.searchTags;
    data['slug'] = this.slug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}
