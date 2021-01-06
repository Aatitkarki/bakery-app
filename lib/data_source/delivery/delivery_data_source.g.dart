// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _DeliveryDataSource implements DeliveryDataSource {
  _DeliveryDataSource(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.buggged.com/bakery';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<DeliveryDistanceResponseModel>> getDeliveryDistances() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/delivery_distance',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            DeliveryDistanceResponseModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
