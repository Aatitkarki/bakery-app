// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ProfileDataSource implements ProfileDataSource {
  _ProfileDataSource(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.buggged.com/bakery';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<LoginUserResponseModel> getMyProfile() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/my_profile',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = LoginUserResponseModel.fromJson(_result.data);
    return value;
  }
}
