import 'package:bakery/core/config/http_config.dart';
import 'package:bakery/data_source/order/models/order_id_model.dart';
import 'package:bakery/data_source/order/models/order_request_model.dart';
import 'package:bakery/data_source/order/models/order_response_model.dart';
import 'package:bakery/data_source/order/models/order_success_model.dart';
import 'package:bakery/data_source/order/models/review_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'models/preauth_response.dart';
import 'models/success_response.dart';

part 'order_data_source.g.dart';

@injectable
@RestApi(baseUrl: HttpConfig.baseURL)
abstract class OrderDataSource {
  @factoryMethod
  factory OrderDataSource(Dio dio) = _OrderDataSource;

  @POST("/order")
  Future<PreAuthResponseModel> requestOrder(
      @Body() OrderRequestModel orderRequestModel);

  @GET("/order")
  Future<List<OrderResponseModel>> getOrders();

  @POST("/payment/pre-authorize")
  Future<PreAuthResponseModel> preAuthorize(@Body() OrderIdModel order);
}
