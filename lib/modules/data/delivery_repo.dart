import 'package:bakery/data_source/delivery/delivery_data_source.dart';
import 'package:bakery/data_source/delivery/model/delivery_distance_response.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class IDeliveryRepo {
  Future<Either<NetworkFailure, List<DeliveryDistanceResponseModel>>>
      getDeliveryDistances();
}

@Injectable(as: IDeliveryRepo)
class DeliveryRepo implements IDeliveryRepo {
  final DeliveryDataSource deliveryDataSource;

  DeliveryRepo(this.deliveryDataSource);

  @override
  Future<Either<NetworkFailure, List<DeliveryDistanceResponseModel>>>
      getDeliveryDistances() async {
    try {
      final foods = await deliveryDataSource.getDeliveryDistances();
      return Right(foods);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }
}
