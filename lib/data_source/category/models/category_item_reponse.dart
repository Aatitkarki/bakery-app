import 'package:bakery/core/config/http_config.dart';

class CategoryItemResponseModel {
  String sId;
  List<String> images;
  int views;
  String name;
  String slug;
  String tagline;
  String createdAt;
  String updatedAt;

  CategoryItemResponseModel(
      {this.sId,
      this.images,
      this.views,
      this.name,
      this.slug,
      this.tagline,
      this.createdAt,
      this.updatedAt});

  CategoryItemResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    images = json['images'].cast<String>();

    if (images != null) {
      for (int i = 0; i < images.length; i++) {
        if (images[i] != null && !images[i].contains("https://"))
          images[i] = HttpConfig.baseURL + images[i];
      }
    }

    views = json['views'];
    name = json['name'];
    slug = json['slug'];
    tagline = json['tagline'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
