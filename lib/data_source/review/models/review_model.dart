class ReviewModel {
  double rating;
  String sId;
  String review;
  String food;
  String customer;
  String createdAt;
  String updatedAt;
  int iV;

  ReviewModel(
      {this.rating,
      this.sId,
      this.review,
      this.food,
      this.customer,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    sId = json['_id'];
    review = json['review'];
    food = json['food'];
    customer = json['customer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['_id'] = this.sId;
    data['review'] = this.review;
    data['food'] = this.food;
    data['customer'] = this.customer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
