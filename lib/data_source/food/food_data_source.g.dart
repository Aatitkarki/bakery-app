// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _FoodDataSource implements FoodDataSource {
  _FoodDataSource(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.buggged.com/bakery';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<FoodItemResponseModel>> getFood() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/food',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            FoodItemResponseModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<FoodItemSlugResponseModel>> getFoodFromSlug(slug) async {
    ArgumentError.checkNotNull(slug, 'slug');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/food/$slug',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            FoodItemSlugResponseModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
