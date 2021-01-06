class FoodItemResponseModel {
  String sId;
  int views;
  List<String> images;
  String name;
  int sellingPrice;
  int markedPrice;
  String slug;
  String createdAt;
  String updatedAt;

  FoodItemResponseModel(
      {this.sId,
      this.views,
      this.images,
      this.name,
      this.sellingPrice,
      this.markedPrice,
      this.slug,
      this.createdAt,
      this.updatedAt});

  FoodItemResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    views = json['views'];
    images = json['images'].cast<String>();
    name = json['name'];
    sellingPrice = json['selling_price'];
    markedPrice = json['marked_price'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['views'] = this.views;
    data['images'] = this.images;
    data['name'] = this.name;
    data['selling_price'] = this.sellingPrice;
    data['marked_price'] = this.markedPrice;
    data['slug'] = this.slug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
