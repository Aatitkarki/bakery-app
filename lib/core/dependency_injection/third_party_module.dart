import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/core/models/app_user_state.dart';
import 'package:bakery/core/services/push_notification_service.dart';
import 'package:bakery/data_source/models/api_exception.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ThirdPartyModules {
  @lazySingleton
  PushNotificationService get pushNotificationService;

  @lazySingleton
  Dio get dio {
    Dio dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (requestOptions) {
        requestOptions.headers.addAll({
          'Authorization': 'Bearer ${AppUserState()?.user?.token ?? ""}',
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json, text/plain, */*',
        });

        Log.debug("DIO REQUEST ${requestOptions.method}",
            requestOptions.baseUrl + requestOptions.uri.path);

        return requestOptions;
      },
      onResponse: (Response response) {
        // Log.debug("DIO RESPONSE", response.data.toString());
        return response;
      },
      onError: customDioErrorInterceptor,
    ));
    return dio;
  }
}

customDioErrorInterceptor(DioError error) {
  Log.debug("DIO ERROR", error?.response?.data?.toString() ?? "No Response");

  if (error.response != null) {
    // that falls out of the range of 2xx and is also not 304;
    try {
      ApiExceptionModel response =
          ApiExceptionModel.fromJson(error.response.data);

      Log.debug("47", response.message);

      throw NetworkFailure(message: response.message);
    } catch (e) {
      Log.debug("51", e.toString());

      if (e is NetworkFailure) throw NetworkFailure(message: e.message);

      Log.debug("55", e.toString());

      throw NetworkFailure(message: "Some Error occured");
    }
  } else {
    // print(
    //     "\n\nSomething happened in setting up or sending the DIO request that triggered an Error.\n\n");
    // print(error.type);

    // Log.debug("DIO error", "resonse is null");
    throw NetworkFailure(message: "Check your connection.");
  }
}
