import 'package:dio/dio.dart';

class NetworkFailure extends DioError {
  String _message;

  String get message => _message;

  NetworkFailure({String message}) : _message = message;

  @override
  String toString() {
    return "Message $message";
  }
}
