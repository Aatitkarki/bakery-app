import 'package:bakery/common/ui/bottom_sheet_wrapper.dart';
import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/core/dependency_injection/injection.dart';
import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/core/models/app_user_state.dart';
import 'package:bakery/core/models/base_page_controller.dart';
import 'package:bakery/core/models/checkout_state.dart';
import 'package:bakery/data_source/checkout/models/checkout_response_model.dart';
import 'package:bakery/data_source/delivery/model/delivery_distance_response.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/data_source/order/models/order_request_model.dart';
import 'package:bakery/data_source/order/models/order_success_model.dart';
import 'package:bakery/data_source/order/models/preauth_response.dart';
import 'package:bakery/modules/data/delivery_repo.dart';
import 'package:bakery/modules/data/order_repo.dart';
import 'package:bakery/modules/features/checkout/view/order_modal.dart';
import 'package:bakery/modules/features/login/view/login_page.dart';
import 'package:get/get.dart';

class CheckoutController extends BasePageController {
  Log log = Log("CheckoutPageController");
  CheckoutState checkoutState;
  TextEditingController addressTextController;

  final IOrderRepo _orderRepo = injection<IOrderRepo>();
  final IDeliveryRepo _deliveryRepo = injection<IDeliveryRepo>();

  double totalAmount() {
    if (_checkoutResponseModelList.isEmpty) return 0.0;

    double amount = _checkoutResponseModelList
            ?.map((e) {
              return e.itemCount * e.sellingPrice;
            })
            ?.reduce((value, element) => value + element)
            ?.toDouble() ??
        0.0;

    return amount;
  }

  @override
  void onInit() {
    log.d("ON INIT");

    addressTextController = TextEditingController();
    checkoutState = CheckoutState();
    loadData();

    super.onInit();
  }

  String _deliveryOption = "pickup";
  String get deliverOption => _deliveryOption;
  bool get isPickup => _deliveryOption.compareTo("pickup") == 0;

  changeDeliveryOption(String deliverOption) {
    _deliveryOption = deliverOption;
    update();
  }

  List<CheckoutResponseModel> _checkoutResponseModelList =
      List<CheckoutResponseModel>();

  List<CheckoutResponseModel> get checkoutResponseModelList =>
      _checkoutResponseModelList;

  loadData() {
    log.d("loadData");

    var data = checkoutState.getData();
    log.d("data extracted from local storage");
    _checkoutResponseModelList = data ?? [];
    update();
    log.d("$checkoutResponseModelList");
  }

  bool isAddedOnCart(String id) {
    for (var x in _checkoutResponseModelList) {
      if (x.sId == id) {
        return true;
      }
    }
    return false;
  }

  bool addToCart(CheckoutResponseModel checkoutResponseModel) {
    if (!isAddedOnCart(checkoutResponseModel.sId)) {
      _checkoutResponseModelList.add(checkoutResponseModel);
      checkoutState.saveData(checkoutResponseModelList);
      getLength();
      update();
      return true;
    }
    return false;
  }

  increaseCartItem(CheckoutResponseModel checkoutResponseModel, int index) {
    _checkoutResponseModelList[index].itemCount++;
    update();
    checkoutState.saveData(checkoutResponseModelList);
  }

  decreaseCartItem(CheckoutResponseModel checkoutResponseModel) {
    int index = _checkoutResponseModelList.indexOf(checkoutResponseModel);
    _checkoutResponseModelList[index].itemCount--;
    update();
    checkoutState.saveData(checkoutResponseModelList);
  }

  removeItem(CheckoutResponseModel checkoutResponseModel) {
    int index = _checkoutResponseModelList.indexOf(checkoutResponseModel);
    _checkoutResponseModelList.removeAt(index);
    getLength();
    update();
    checkoutState.saveData(checkoutResponseModelList);
  }

  getLength() {
    return checkoutResponseModelList.length;
  }

  @override
  void onClose() {
    addressTextController.dispose();
    super.onClose();
  }

  List<DeliveryDistanceResponseModel> _distances;

  bool _gettingDistance = false;
  bool get gettingDistance => _gettingDistance;

  Future getDeliveryDistances() async {
    _gettingDistance = true;
    update();
    final foods = await _deliveryRepo.getDeliveryDistances();

    foods.fold(
      (NetworkFailure l) {
        Get.snackbar("Order Failed", l.message);
      },
      (List<DeliveryDistanceResponseModel> r) {
        _distances = r;

        _gettingDistance = false;
        update();
      },
    );
    log.d("at last");
    _gettingDistance = false;
    update();
  }

  void placeOrder() async {
    if (!AppUserState().isLoggedIn) {
      await Get.bottomSheet(LoginPage());
    }

    if (isLoading == false) {
      if (!isPickup) {
        await getDeliveryDistances();
      }

      Get.bottomSheet(
        BottomSheetWrapper(
          child: OrderModal(
            isPickup: isPickup,
            distances: _distances,
          ),
        ),
      );

      // OrderRequestModel orderRequestModel =
      //     OrderRequestModel(addressNote: address, foods: foods);

      // requestOrder(orderRequestModel);
    }
  }

  Future requestOrder(OrderRequestModel orderRequestModel) async {
    setLoading(true);

    final order = await _orderRepo.requestOrder(orderRequestModel);

    order.fold(
      (NetworkFailure l) {
        Get.snackbar(
          "Order requesting failed",
          l.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (PreAuthResponseModel r) {
        // orderSuccessModel = r;
        // TODO preauthorize
        setLoading(false);
      },
    );

    setLoading(false);
  }
}
