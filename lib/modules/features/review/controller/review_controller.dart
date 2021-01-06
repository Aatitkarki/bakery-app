import 'package:bakery/common/ui/k_toast.dart';
import 'package:bakery/core/dependency_injection/injection.dart';
import 'package:bakery/core/models/base_page_controller.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/data_source/order/models/order_response_model.dart';
import 'package:bakery/data_source/review/models/review_request_model.dart';
import 'package:bakery/data_source/review/models/review_response_model.dart';
import 'package:bakery/modules/data/review_repo.dart';
import 'package:flutter/widgets.dart';

class ReviewController extends BasePageController {
  TextEditingController kReviewTextController;

  @override
  void onInit() {
    super.onInit();
    kReviewTextController = TextEditingController();
  }

  ReviewResponseModel reviewResponseModel;

  final IReviewRepo _reviewRepo = injection<IReviewRepo>();

  Future addReview(OrderResponseModel order) async {
    if (kReviewTextController?.text == null ||
        kReviewTextController.text.isEmpty) {
      KToast.e("Please add a valid review");
      return;
    }

    setLoading();
    setFailure();

    final review = await _reviewRepo.addReview(
      ReviewRequestModel(
        rating: _rating,
        review: kReviewTextController.text,
        order: order.sId,
      ),
    );

    review.fold((NetworkFailure l) {
      KToast.e(l.message);
    }, (ReviewResponseModel r) {
      setLoading(false);
      update();
      KToast.s("Reviewed successfully");
    });

    setLoading(false);
  }

  @override
  void onClose() {
    super.onClose();
    kReviewTextController.dispose();
  }

  double _rating = 5;

  void updateRating(double value) {
    _rating = value;
    update();
  }
}
