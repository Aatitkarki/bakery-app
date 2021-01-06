import 'package:bakery/core/dependency_injection/injection.dart';
import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/core/models/base_page_controller.dart';
import 'package:bakery/data_source/food/models/food_item_response.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/modules/data/food_repo.dart';

class FoodItemController extends BasePageController {
  Log log = Log("Food Item controller");
  List<FoodItemResponseModel> foodItemModel;

  IFoodRepo _foodRepo = injection<IFoodRepo>();

  @override
  void onInit() {
    getFood();
    super.onInit();
  }

  Future getFood() async {
    setFailure();
    setLoading(true);
    final foods = await _foodRepo.getFood();

    foods.fold((NetworkFailure l) {
      setFailure(l.message);
    }, (List<FoodItemResponseModel> r) {
      foodItemModel = r;
      setLoading(false);
      update();
    });

    setLoading(false);
  }
}
