import 'package:bakery/core/config/http_config.dart';
import 'package:bakery/data_source/auth/models/login_request.dart';
import 'package:bakery/data_source/auth/models/login_response.dart';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/http.dart';

part 'auth_data_source.g.dart';

@injectable
@RestApi(baseUrl: HttpConfig.baseURL)
abstract class AuthDataSource {
  @factoryMethod
  factory AuthDataSource(Dio dio) = _AuthDataSource;

  @POST("/login")
  Future<LoginResponseModel> login(@Body() LoginRequestModel requestModel);
}
