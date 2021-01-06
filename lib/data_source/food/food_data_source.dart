import 'package:bakery/core/config/http_config.dart';
import 'package:bakery/data_source/food/models/food_item_response.dart';
import 'package:bakery/data_source/food/models/food_item_slug_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'food_data_source.g.dart';

@injectable
@RestApi(baseUrl: HttpConfig.baseURL)
abstract class FoodDataSource {
  @factoryMethod
  factory FoodDataSource(Dio dio) = _FoodDataSource;

  @GET("/food")
  Future<List<FoodItemResponseModel>> getFood();

  @GET("/food/{slug}")
  Future<List<FoodItemSlugResponseModel>> getFoodFromSlug(
      @Path("slug") String slug);
}
