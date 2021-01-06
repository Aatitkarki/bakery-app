// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CategoryDataSource implements CategoryDataSource {
  _CategoryDataSource(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.buggged.com/bakery';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<CategoryItemResponseModel>> getCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/category',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            CategoryItemResponseModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<CategoryItemSlugResponseModel> getCategoryFromSlug(slug) async {
    ArgumentError.checkNotNull(slug, 'slug');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/category/$slug',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CategoryItemSlugResponseModel.fromJson(_result.data);
    return value;
  }
}
