class ReviewRequestModel {
  String review;
  double rating;
  String order;

  ReviewRequestModel({this.review, this.rating, this.order});

  ReviewRequestModel.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    rating = json['rating'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['order'] = this.order;
    return data;
  }
}
