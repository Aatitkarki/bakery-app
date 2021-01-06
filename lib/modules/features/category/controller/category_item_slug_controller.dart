import 'package:bakery/core/dependency_injection/injection.dart';
import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/core/models/base_page_controller.dart';
import 'package:bakery/data_source/category/models/category_item_slug_response.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/modules/data/category_repo.dart';

class CategoryItemSlugController extends BasePageController {
  Log log = Log("CategoryItemSlugController");
  CategoryItemSlugResponseModel categoryItemSlugModel;

  final ICategoryRepo _categoryRepo = injection<ICategoryRepo>();

  Future getCategoriesFromSlug(String slug) async {
    setLoading(true);

    final cateogoriesFromSlug = await _categoryRepo.getCategoryFromSlug(slug);

    cateogoriesFromSlug.fold((NetworkFailure l) {
      setFailure(l.message);
    }, (CategoryItemSlugResponseModel r) {
      categoryItemSlugModel = r;
      setLoading(false);
      update();
    });

    setLoading(false);
  }

  @override
  void onInit() {
    log.d("INIT CALLED");
    // getCategoriesFromSlug();
    super.onInit();
  }

  @override
  void onReady() {
    log.d("READT CALLED");

    super.onReady();
  }
}
