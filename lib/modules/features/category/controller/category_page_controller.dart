// List<Categores>
// addCategory
// getCategories => categoryRepo.getCategories
// loading => true
// hasfailure => ""failure"" != null
//
import 'package:bakery/core/dependency_injection/injection.dart';
import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/core/models/base_page_controller.dart';
import 'package:bakery/data_source/category/models/category_item_reponse.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/modules/data/category_repo.dart';

class CategoryPageController extends BasePageController {
  Log log = Log("CategoryPageController");

  List<CategoryItemResponseModel> categoryItemModel;

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  final ICategoryRepo _categoryRepo = injection<ICategoryRepo>();

  Future getCategories() async {
    setFailure();
    setLoading(true);
    final categories = await _categoryRepo.getCategories();

    categories.fold((NetworkFailure l) {
      setFailure(l.message);
    }, (List<CategoryItemResponseModel> r) {
      categoryItemModel = r;
      setLoading(false);
      update();
    });
    setLoading(false);
  }
}
