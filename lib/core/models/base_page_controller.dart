import 'package:get/get.dart';

abstract class BasePageController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading([bool loading = true]) {
    _isLoading = loading;
    update();
  }

  String _failure;
  String get failure => _failure;
  bool get hasFailure => (_failure != null) && _failure.trim().isNotEmpty;

  setFailure([String failure]) {
    _failure = failure;
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
