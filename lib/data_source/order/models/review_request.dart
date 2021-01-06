class ReviewRequestModel {
  String review;
  double rating;
  String food;

  ReviewRequestModel({this.review, this.rating, this.food});

  ReviewRequestModel.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    rating = json['rating'];
    food = json['food'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['food'] = this.food;
    return data;
  }
}
