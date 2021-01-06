import 'package:bakery/core/config/http_config.dart';
import 'package:bakery/data_source/order/models/preauth_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import 'models/gift_card_buy_request.dart';
import 'models/gift_card_response.dart';
import 'models/my_gift_card_response.dart';

part 'gift_card_data_source.g.dart';

@injectable
@RestApi(baseUrl: HttpConfig.baseURL)
abstract class GiftCardDataSource {
  @factoryMethod
  factory GiftCardDataSource(Dio dio) = _GiftCardDataSource;

  @GET("/gift_card")
  Future<List<GiftCardResponseModel>> getGiftCards();

  @GET("/my_gift_card")
  Future<List<MyGiftCardResponseModel>> getMyGiftCards();

  @POST("/my_gift_card")
  Future<PreAuthResponseModel> buyGiftCard(
      @Body() GiftCardBuyRequestModel request);
}
