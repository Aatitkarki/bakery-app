import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/data_source/order/models/order_id_model.dart';
import 'package:bakery/data_source/order/models/order_request_model.dart';
import 'package:bakery/data_source/order/models/order_response_model.dart';
import 'package:bakery/data_source/order/models/order_success_model.dart';
import 'package:bakery/data_source/order/models/preauth_response.dart';
import 'package:bakery/data_source/order/order_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class IOrderRepo {
  Future<Either<NetworkFailure, List<OrderResponseModel>>> getOrders();

  Future<Either<NetworkFailure, PreAuthResponseModel>> requestOrder(
      OrderRequestModel orderRequestModel);

  Future<Either<NetworkFailure, PreAuthResponseModel>> preAuthorize(
      OrderIdModel order);
}

@Injectable(as: IOrderRepo)
class OrderRepo implements IOrderRepo {
  final OrderDataSource orderDataSource;

  OrderRepo(this.orderDataSource);

  @override
  Future<Either<NetworkFailure, List<OrderResponseModel>>> getOrders() async {
    try {
      final orders = await orderDataSource.getOrders();

      return Right(orders);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, PreAuthResponseModel>> requestOrder(
      OrderRequestModel orderRequestModel) async {
    try {
      final orders = await orderDataSource.requestOrder(orderRequestModel);

      return Right(orders);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, PreAuthResponseModel>> preAuthorize(
      OrderIdModel order) async {
    try {
      final orders = await orderDataSource.preAuthorize(order);

      return Right(orders);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }
}
