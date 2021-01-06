import 'package:bakery/core/config/http_config.dart';
import 'package:bakery/data_source/category/models/category_item_slug_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart';

import 'models/category_item_reponse.dart';

part 'category_data_source.g.dart';

@injectable
@RestApi(baseUrl: HttpConfig.baseURL)
abstract class CategoryDataSource {
  @factoryMethod
  factory CategoryDataSource(Dio dio) = _CategoryDataSource;

  @GET("/category")
  Future<List<CategoryItemResponseModel>> getCategories();

  @GET("/category/{slug}")
  Future<CategoryItemSlugResponseModel> getCategoryFromSlug(
      @Path("slug") String slug);
}
