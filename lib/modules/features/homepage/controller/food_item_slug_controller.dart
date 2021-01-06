import 'package:bakery/core/dependency_injection/injection.dart';
import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/core/models/base_page_controller.dart';
import 'package:bakery/data_source/food/models/food_item_slug_response.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/modules/data/food_repo.dart';

class FoodItemSlugController extends BasePageController {
  Log log = Log("Food Item Slug controller");
  List<FoodItemSlugResponseModel> foodItemModel;

  IFoodRepo _foodRepo = injection<IFoodRepo>();

  Future getFoodFromSlug(String slug) async {
    setLoading(true);
    final foods = await _foodRepo.getFoodFromSlug(slug);

    foods.fold((NetworkFailure l) {
      setFailure(l.message);
    }, (List<FoodItemSlugResponseModel> r) {
      foodItemModel = r;
      print(foodItemModel);
      Log.debug("45", "Food Slug added");
      setLoading(false);
      update();
    });
    setLoading(false);
  }
}
