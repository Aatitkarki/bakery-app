import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/data_source/checkout/models/checkout_response_model.dart';
import 'package:get_storage/get_storage.dart';

final _checkoutKey = "CHECKOUT";

class CheckoutState {
  Log log = Log("CheckoutState");
  CheckoutState._();

  factory CheckoutState() {
    return _instance;
  }
  static final _instance = CheckoutState._();

  final GetStorage checkoutStorage = GetStorage();

  saveData(List<CheckoutResponseModel> checkoutResponseModelList) {
    checkoutStorage.remove(_checkoutKey);
    checkoutStorage.write(_checkoutKey, checkoutResponseModelList.toList());
    var data = getData();
    log.i("$data");
  }

  List<CheckoutResponseModel> getData() {
    log.d("getData");
    if (checkoutStorage != null) {
      final rawData = checkoutStorage.read<List>(_checkoutKey);
      log.d("the raw data is");
      log.d("$rawData");
      if (rawData != null) {
        return rawData.map((e) => CheckoutResponseModel.fromJson(e)).toList();
      }
      return null;
    }
  }

  clear() {
    checkoutStorage.remove(_checkoutKey);
  }
}
