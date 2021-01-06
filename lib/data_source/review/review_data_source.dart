import 'package:bakery/core/config/http_config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import 'models/review_request_model.dart';
import 'models/review_response_model.dart';

part 'review_data_source.g.dart';

@injectable
@RestApi(baseUrl: HttpConfig.baseURL)
abstract class ReviewDataSource {
  @factoryMethod
  factory ReviewDataSource(Dio dio) = _ReviewDataSource;

  @POST("/reviews")
  Future<ReviewResponseModel> addReview(
      @Body() ReviewRequestModel reviewRequestModel);
}
