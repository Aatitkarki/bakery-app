import 'package:bakery/data_source/auth/auth_data_source.dart';
import 'package:bakery/data_source/auth/models/login_request.dart';
import 'package:bakery/data_source/auth/models/login_response.dart';
import 'package:bakery/data_source/category/models/category_item_reponse.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class IAuthRepo {
  Future<Either<NetworkFailure, LoginResponseModel>> login(
      LoginRequestModel requestModel);
}

@Injectable(as: IAuthRepo)
class AuthRepo implements IAuthRepo {
  final AuthDataSource authDataSource;

  AuthRepo(this.authDataSource);

  @override
  Future<Either<NetworkFailure, LoginResponseModel>> login(
      LoginRequestModel requestModel) async {
    try {
      final response = await authDataSource.login(requestModel);

      return Right(response);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }
}
