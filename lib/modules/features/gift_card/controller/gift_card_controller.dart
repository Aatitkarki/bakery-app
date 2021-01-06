import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/core/config/stripe_config.dart';
import 'package:bakery/core/dependency_injection/injection.dart';
import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/core/models/base_page_controller.dart';
import 'package:bakery/data_source/gift_card/models/gift_card_buy_request.dart';
import 'package:bakery/data_source/gift_card/models/gift_card_response.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/data_source/order/models/order_id_model.dart';
import 'package:bakery/data_source/order/models/order_response_model.dart';
import 'package:bakery/data_source/order/models/preauth_response.dart';
import 'package:bakery/modules/data/gift_card_repo.dart';
import 'package:bakery/modules/data/order_repo.dart';
import 'package:bakery/modules/features/review/view/review_page.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stripe_payment/stripe_payment.dart';

class GiftCardController extends BasePageController {
  Log log = Log("GiftCardController: ");
  final IGiftCardRepo _giftCardRepo = injection<IGiftCardRepo>();

  @override
  void onInit() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: StripeConfig.publishableKey,
        merchantId: "Test",
        androidPayMode: 'test',
      ),
    );

    getGiftCards();

    super.onInit();
  }

  List<GiftCardResponseModel> _giftCards;
  List<GiftCardResponseModel> get giftCards => _giftCards;

  Future getGiftCards() async {
    setFailure();
    setLoading(true);

    final response = await _giftCardRepo.getGiftCards();

    response.fold(
      (NetworkFailure l) {
        setFailure(l.message);
      },
      (List<GiftCardResponseModel> r) {
        _giftCards = r;
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

  buyGiftCard(GiftCardResponseModel card) async {
    _preauthorizing = card.sId;
    update();

    final response = await _giftCardRepo
        .buyGiftCard(GiftCardBuyRequestModel(giftCard: card.sId));

    response.fold(
      (NetworkFailure l) {
        Get.snackbar("Preauth failed", "TOOD");
      },
      (PreAuthResponseModel r) {
        Get.defaultDialog(
          radius: 4,
          title: "Purchase Gift Card",
          textConfirm: "Yes",
          confirmTextColor: Colors.white,
          buttonColor: kPrimaryColor,
          onConfirm: () async {
            await preauthorizeWithStripe(r.clientSecret);
            Get.back();
          },
          onCancel: () {
            Get.back();
          },
          textCancel: "No",
          cancelTextColor: kPrimaryColor,
          middleText:
              "Are you sure you want to purchase this gift card?\n\nAmount: \$${r.amount}",
        );
      },
    );

    _preauthorizing = null;
    update();
  }

  bool _preauthorizingCard = false;

  Future preauthorizeWithStripe(String clientSecret) async {
    try {
      var _paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest(),
      );

      _preauthorizingCard = true;
      update();
      var response = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: clientSecret,
          paymentMethodId: _paymentMethod.id,
        ),
      );

      print("\n\nResponse Status\n\n");
      print(response.status);
      print("\n\n");

      if (response.status.toLowerCase().compareTo("succeeded") == 0) {
        _success = true;
        update();
        _preauthorizingCard = false;
        update();
        KToast.s("Gift card purchased.\nPlease check it from your profile.");

        Future.delayed(Duration(milliseconds: 100), () {
          return true;
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
      _preauthorizingCard = false;
      update();
      Future.delayed(Duration(milliseconds: 100), () {
        // _navigationService.pop(false);
      });
    } catch (e) {
      Get.snackbar("Preauthorize failed", e.message);
      _preauthorizingCard = false;
      update();
      Future.delayed(Duration(milliseconds: 100), () {
        // _navigationService.pop(false);
      });
    }

    _preauthorizingCard = false;
    update();
  }
}
