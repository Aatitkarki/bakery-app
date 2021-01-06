import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/core/config/stripe_config.dart';
import 'package:bakery/core/dependency_injection/injection.dart';
import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/core/models/base_page_controller.dart';
import 'package:bakery/data_source/gift_card/models/gift_card_buy_request.dart';
import 'package:bakery/data_source/gift_card/models/gift_card_response.dart';
import 'package:bakery/data_source/gift_card/models/my_gift_card_response.dart';
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

class MyGiftCardController extends BasePageController {
  Log log = Log("MyGiftCardController");
  final IGiftCardRepo _giftCardRepo = injection<IGiftCardRepo>();

  @override
  void onInit() {
    super.onInit();
    getMyGiftCards();
  }

  List<MyGiftCardResponseModel> _giftCards;
  List<MyGiftCardResponseModel> get giftCards => _giftCards;

  Future getMyGiftCards() async {
    setFailure();
    setLoading(true);

    final response = await _giftCardRepo.getMyGiftCards();

    response.fold(
      (NetworkFailure l) {
        setFailure(l.message);
      },
      (List<MyGiftCardResponseModel> r) {
        _giftCards = r;
        setLoading(false);
        update();
      },
    );
    setLoading(false);
  }
}
