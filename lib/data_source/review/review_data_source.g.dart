// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ReviewDataSource implements ReviewDataSource {
  _ReviewDataSource(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.buggged.com/bakery';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ReviewResponseModel> addReview(reviewRequestModel) async {
    ArgumentError.checkNotNull(reviewRequestModel, 'reviewRequestModel');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(reviewRequestModel?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/reviews',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ReviewResponseModel.fromJson(_result.data);
    return value;
  }
}
