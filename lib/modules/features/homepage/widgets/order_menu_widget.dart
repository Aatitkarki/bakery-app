import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/modules/features/category/controller/category_page_controller.dart';
import 'package:bakery/modules/features/category/view/category_page.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderMenuWidget extends StatelessWidget {
  final bool off;

  final CategoryPageController _categoryPageController =
      Get.put(CategoryPageController());

  OrderMenuWidget({Key key, this.off = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: mXPadding,
      height: size.height * 0.15,
      child: GetBuilder<CategoryPageController>(
        builder: (_categoryPageController) => _categoryPageController.isLoading
            ? Center(child: CircularProgressIndicator())
            : _categoryPageController.hasFailure
                ? Center(
                    child: Text(_categoryPageController.failure),
                  )
                : Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:
                          _categoryPageController.categoryItemModel.map((e) {
                        return GestureDetector(
                          onTap: () {
                            if (off) {
                              Get.off(
                                CategoryPage(slug: "${e.slug}"),
                                preventDuplicates: false,
                              );
                            } else {
                              Get.to(
                                CategoryPage(slug: "${e.slug}"),
                                preventDuplicates: false,
                              );
                            }
                          },
                          child: Padding(
                            padding: sXPadding,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
//borderRadius: BorderRadius.circular(50),
                                    shape: BoxShape.circle,
                                    color: kPrimaryColor,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        "${e.images[0]}",
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  e.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
      ),
    );
  }
}
