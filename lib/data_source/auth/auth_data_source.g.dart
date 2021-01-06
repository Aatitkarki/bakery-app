// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AuthDataSource implements AuthDataSource {
  _AuthDataSource(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.buggged.com/bakery';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<LoginResponseModel> login(requestModel) async {
    ArgumentError.checkNotNull(requestModel, 'requestModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(requestModel?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = LoginResponseModel.fromJson(_result.data);
    return value;
  }
}
