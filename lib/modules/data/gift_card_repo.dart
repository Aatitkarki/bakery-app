import 'package:bakery/data_source/delivery/model/delivery_distance_response.dart';
import 'package:bakery/data_source/gift_card/gift_card_data_source.dart';
import 'package:bakery/data_source/gift_card/models/gift_card_buy_request.dart';
import 'package:bakery/data_source/gift_card/models/gift_card_response.dart';
import 'package:bakery/data_source/gift_card/models/my_gift_card_response.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/data_source/order/models/preauth_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class IGiftCardRepo {
  Future<Either<NetworkFailure, List<GiftCardResponseModel>>> getGiftCards();
  Future<Either<NetworkFailure, List<MyGiftCardResponseModel>>>
      getMyGiftCards();
  Future<Either<NetworkFailure, PreAuthResponseModel>> buyGiftCard(
      GiftCardBuyRequestModel request);
}

@Injectable(as: IGiftCardRepo)
class GiftCardRepo implements IGiftCardRepo {
  final GiftCardDataSource dataSource;

  GiftCardRepo(this.dataSource);

  @override
  Future<Either<NetworkFailure, PreAuthResponseModel>> buyGiftCard(
      GiftCardBuyRequestModel request) async {
    try {
      final foods = await dataSource.buyGiftCard(request);
      return Right(foods);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, List<GiftCardResponseModel>>>
      getGiftCards() async {
    try {
      final foods = await dataSource.getGiftCards();
      return Right(foods);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, List<MyGiftCardResponseModel>>>
      getMyGiftCards() async {
    try {
      final foods = await dataSource.getMyGiftCards();
      return Right(foods);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }
}
