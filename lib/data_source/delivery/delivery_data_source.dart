import 'package:bakery/core/config/http_config.dart';
import 'package:bakery/data_source/delivery/model/delivery_distance_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'delivery_data_source.g.dart';

@injectable
@RestApi(baseUrl: HttpConfig.baseURL)
abstract class DeliveryDataSource {
  @factoryMethod
  factory DeliveryDataSource(Dio dio) = _DeliveryDataSource;

  @GET("/delivery_distance")
  Future<List<DeliveryDistanceResponseModel>> getDeliveryDistances();
}
