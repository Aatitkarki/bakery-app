import 'package:bakery/data_source/food/food_data_source.dart';
import 'package:bakery/data_source/food/models/food_item_response.dart';
import 'package:bakery/data_source/food/models/food_item_slug_response.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class IFoodRepo {
  Future<Either<NetworkFailure, List<FoodItemResponseModel>>> getFood();

  Future<Either<NetworkFailure, List<FoodItemSlugResponseModel>>>
      getFoodFromSlug(String slug);
}

@Injectable(as: IFoodRepo)
class FoodRepo implements IFoodRepo {
  final FoodDataSource foodDataSource;

  FoodRepo(this.foodDataSource);

  @override
  Future<Either<NetworkFailure, List<FoodItemResponseModel>>> getFood() async {
    try {
      final foods = await foodDataSource.getFood();
      return Right(foods);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, List<FoodItemSlugResponseModel>>>
      getFoodFromSlug(String slug) async {
    try {
      final foodFromSlug = await foodDataSource.getFoodFromSlug(slug);
      return Right(foodFromSlug);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }
}
