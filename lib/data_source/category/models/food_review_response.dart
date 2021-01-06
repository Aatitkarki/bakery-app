class FoodReviewResponseModel {
  String sId;
  String name;
  String slug;

  FoodReviewResponseModel({this.sId, this.name, this.slug});

  FoodReviewResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}
