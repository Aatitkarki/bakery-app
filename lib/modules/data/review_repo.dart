import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/data_source/review/models/review_request_model.dart';
import 'package:bakery/data_source/review/models/review_response_model.dart';
import 'package:bakery/data_source/review/review_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class IReviewRepo {
  Future<Either<NetworkFailure, ReviewResponseModel>> addReview(
      ReviewRequestModel reviewRequestModel);
}

@Injectable(as: IReviewRepo)
class ReviewRepo implements IReviewRepo {
  final ReviewDataSource reviewDataSource;

  ReviewRepo({this.reviewDataSource});

  @override
  Future<Either<NetworkFailure, ReviewResponseModel>> addReview(
      ReviewRequestModel reviewRequestModel) async {
    try {
      final review = await reviewDataSource.addReview(reviewRequestModel);
      return Right(review);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }
}
