import 'package:bakery/core/config/http_config.dart';
import 'package:bakery/data_source/auth/models/login_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_data_source.g.dart';

@injectable
@RestApi(baseUrl: HttpConfig.baseURL)
abstract class ProfileDataSource {
  @factoryMethod
  factory ProfileDataSource(Dio dio) = _ProfileDataSource;

  @GET("/my_profile")
  Future<LoginUserResponseModel> getMyProfile();
}
