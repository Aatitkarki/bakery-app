import 'package:bakery/data_source/auth/models/login_response.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/data_source/profile/profile_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class IProfileRepo {
  Future<Either<NetworkFailure, LoginUserResponseModel>> getMyProfile();
}

@Injectable(as: IProfileRepo)
class ProfileRepo implements IProfileRepo {
  final ProfileDataSource profileDataSource;

  ProfileRepo(this.profileDataSource);

  @override
  Future<Either<NetworkFailure, LoginUserResponseModel>> getMyProfile() async {
    try {
      final response = await profileDataSource.getMyProfile();

      return Right(response);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }
}
