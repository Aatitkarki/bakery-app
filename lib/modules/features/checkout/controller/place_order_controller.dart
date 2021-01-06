import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/core/dependency_injection/injection.dart';
import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/core/models/base_page_controller.dart';
import 'package:bakery/core/models/checkout_state.dart';
import 'package:bakery/data_source/checkout/models/checkout_response_model.dart';
import 'package:bakery/data_source/delivery/model/delivery_distance_response.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/data_source/order/models/order_request_model.dart';
import 'package:bakery/data_source/order/models/order_success_model.dart';
import 'package:bakery/data_source/order/models/preauth_response.dart';
import 'package:bakery/modules/data/order_repo.dart';
import 'package:bakery/modules/features/orders/controller/order_controller.dart';
import 'package:bakery/theme/colors.dart';
import 'package:get/get.dart';

import 'checkout_controller.dart';

class PlaceOrderController extends BasePageController {
  Log log = Log("PlaceOrderController");
  CheckoutState checkoutState;
  TextEditingController phoneNumberController, orderNoteController;

  final IOrderRepo _orderRepo = injection<IOrderRepo>();

  DeliveryDistanceResponseModel _chosen;
  DeliveryDistanceResponseModel get chosen => _chosen;
  void chooseDeliveryDistance(DeliveryDistanceResponseModel d) {
    _chosen = d;
    update();
  }

  List<DeliveryDistanceResponseModel> distances;
  bool isPickup;

  void init(bool isPickup, List<DeliveryDistanceResponseModel> distances) {
    this.distances = distances;
    if (distances?.isNotEmpty ?? false) _chosen = distances[0];
    this.isPickup = isPickup;
    update();
  }

  @override
  void onInit() {
    phoneNumberController = TextEditingController();
    orderNoteController = TextEditingController();
    checkoutState = CheckoutState();

    loadData();

    super.onInit();
  }

  List<CheckoutResponseModel> _checkoutResponseModelList =
      List<CheckoutResponseModel>();

  loadData() {
    _checkoutResponseModelList = checkoutState.getData() ?? [];
  }

  Future requestOrder() async {
    String _error = "";
    if (phoneNumberController.text.isEmpty) {
      _error += "Phone number is required";
    }

    if (orderNoteController.text.isEmpty) {
      if (_error.isNotEmpty) _error += "\n";
      _error += "Order Note is required";
    }

    if (_checkoutResponseModelList == null ||
        _checkoutResponseModelList.isEmpty) {
      if (_error.isNotEmpty) _error += "\n";
      _error += "No Items have been checkout";
    }

    if (_error.isNotEmpty) {
      Get.snackbar("Order Failed", _error);
      return;
    }

    OrderRequestModel orderRequestModel = OrderRequestModel(
      phone: phoneNumberController.text,
      addressNote: orderNoteController.text,
      deliveryDistanceId: chosen?.sId,
      foods: _checkoutResponseModelList.map((e) => e.sId).toList(),
      quantity: _checkoutResponseModelList.map((e) => e.itemCount).toList(),
    );

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

        checkoutState.clear();
        CheckoutController controller = Get.find();
        controller.loadData();
        KToast.s("Order placed successfully");

        Get.defaultDialog(
          title: "Pre-Authorize order",
          textConfirm: "Yes",
          confirmTextColor: Colors.white,
          buttonColor: kPrimaryColor,
          onConfirm: () async {
            OrderController _controller = Get.find();
            await _controller.preauthorizeWithStripe(r.clientSecret);
            Get.back();
          },
          textCancel: "No",
          cancelTextColor: kPrimaryColor,
          middleText:
              "Are you sure you want to pre auth this order?\n\nAmount: \$${r.amount}",
        );

        setLoading(false);
      },
    );

    setLoading(false);
  }
}
