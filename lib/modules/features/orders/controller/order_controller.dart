import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/core/config/stripe_config.dart';
import 'package:bakery/core/dependency_injection/injection.dart';
import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/core/models/base_page_controller.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/data_source/order/models/order_id_model.dart';
import 'package:bakery/data_source/order/models/order_response_model.dart';
import 'package:bakery/data_source/order/models/preauth_response.dart';
import 'package:bakery/modules/data/order_repo.dart';
import 'package:bakery/modules/features/review/view/review_page.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stripe_payment/stripe_payment.dart';

class OrderController extends BasePageController {
  Log log = Log("OrderController: ");
  final IOrderRepo _orderRepo = injection<IOrderRepo>();

  @override
  void onInit() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: StripeConfig.publishableKey,
        merchantId: "Test",
        androidPayMode: 'test',
      ),
    );

    getOrders();

    super.onInit();
  }

  List<OrderResponseModel> _orderResponseList;
  List<OrderResponseModel> get orderResponseList => _orderResponseList;

  Future getOrders() async {
    setFailure();
    setLoading(true);

    final response = await _orderRepo.getOrders();

    response.fold(
      (NetworkFailure l) {
        setFailure(l.message);
      },
      (List<OrderResponseModel> r) {
        _orderResponseList = r;
        setLoading(false);
        update();
      },
    );
    setLoading(false);
  }

  bool _success = false;
  bool get success => _success;

  String _preauthorizing;
  String get preauthorizing => _preauthorizing;

  onPayPressed(OrderResponseModel order) async {
    _preauthorizing = order.sId;
    update();

    final response =
        await _orderRepo.preAuthorize(OrderIdModel(order: order.sId));

    response.fold(
      (NetworkFailure l) {
        Get.snackbar("Preauth failed", "TOOD");
      },
      (PreAuthResponseModel r) {
        Get.defaultDialog(
          title: "Pre-Authorize order",
          textConfirm: "Yes",
          confirmTextColor: Colors.white,
          buttonColor: kPrimaryColor,
          onConfirm: () {
            preauthorizeWithStripe(r.clientSecret);
          },
          textCancel: "No",
          cancelTextColor: kPrimaryColor,
          middleText:
              "Are you sure you want to pre auth this order?\n\nAmount: \$${r.amount}",
        );
      },
    );

    _preauthorizing = null;
    update();
  }

  Future preauthorizeWithStripe(String clientSecret) async {
    try {
      var _paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest(),
      );

      setLoading(true);
      var response = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: clientSecret,
          paymentMethodId: _paymentMethod.id,
        ),
      );

      print("\n\nResponse Status\n\n");
      print(response.status);
      print("\n\n");

      if (response.status.toLowerCase().compareTo("requires_capture") == 0) {
        _success = true;
        update();
        setLoading(false);
        KToast.s("Preauthorize success");

        Future.delayed(Duration(milliseconds: 100), () {
          Get.back();
        });
      } else {
        Future.delayed(Duration(milliseconds: 100), () {
          print("\n\n\n\n");
          response.printError();
          print("\n\n\n\n");
          response.printInfo();
          print("\n\n\n\n");

          Get.snackbar("Preauthorize failed", "Preauthorize failed");
        });
      }
    } on PlatformException catch (e) {
      Get.snackbar("Preauthorize failed", e.message);
      setLoading(false);
      Future.delayed(Duration(milliseconds: 100), () {
        // _navigationService.pop(false);
      });
    } catch (e) {
      Get.snackbar("Preauthorize failed", e.message);
      setLoading(false);
      Future.delayed(Duration(milliseconds: 100), () {
        // _navigationService.pop(false);
      });
    }

    setLoading(false);
  }

  String _reviewing;
  String get reviewing => null;

  void onReviewPressed(OrderResponseModel order) {
    Get.to(ReviewPage(order: order));
  }
}
