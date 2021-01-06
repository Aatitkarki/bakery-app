// Future<Either<Failure, List<Categories>>  getCategories();
import 'package:bakery/data_source/category/category_data_source.dart';
import 'package:bakery/data_source/category/models/category_item_slug_response.dart';
import 'package:dartz/dartz.dart';
import 'package:bakery/data_source/category/models/category_item_reponse.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:injectable/injectable.dart';

abstract class ICategoryRepo {
  Future<Either<NetworkFailure, List<CategoryItemResponseModel>>>
      getCategories();

  Future<Either<NetworkFailure, CategoryItemSlugResponseModel>>
      getCategoryFromSlug(String slug);
}

@Injectable(as: ICategoryRepo)
class CategoryRepo implements ICategoryRepo {
  final CategoryDataSource categoryDataSource;

  CategoryRepo(this.categoryDataSource);

  @override
  Future<Either<NetworkFailure, List<CategoryItemResponseModel>>>
      getCategories() async {
    try {
      final categories = await categoryDataSource.getCategories();

      return Right(categories);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<NetworkFailure, CategoryItemSlugResponseModel>>
      getCategoryFromSlug(String slug) async {
    try {
      final categoryFromSlug =
          await categoryDataSource.getCategoryFromSlug(slug);
      return Right(categoryFromSlug);
    } on NetworkFailure catch (e) {
      return Left(e);
    }
  }
}
