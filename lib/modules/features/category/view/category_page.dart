import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/data_source/checkout/models/checkout_response_model.dart';
import 'package:bakery/modules/features/category/controller/category_item_slug_controller.dart';
import 'package:bakery/modules/features/category/widgets/custom_appbar_widget.dart';

import 'package:bakery/modules/features/category/widgets/menu_item_widget.dart';
import 'package:bakery/modules/features/category/widgets/review_widget.dart';
import 'package:bakery/modules/features/checkout/controller/checkout_controller.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends StatelessWidget {
  final String slug;

  CategoryPage({this.slug}) {
    _categoryItemSlugController.getCategoriesFromSlug(slug);
  }

  final CategoryItemSlugController _categoryItemSlugController = Get.put(
    CategoryItemSlugController(),
    permanent: true,
  );

  final CheckoutController checkoutController = Get.find();

  final List<Tab> tabList = [
    Tab(
      text: "Menu Items",
    ),
    Tab(
      text: "Reviews",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(340),
          child: GetBuilder<CategoryItemSlugController>(
            builder: (_categoryPageController) => Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: _categoryPageController.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : CustomAppBarWidget(controller: _categoryPageController),
                ),
                TabBar(
                  tabs: tabList,
                  unselectedLabelColor: kSecondaryTextColor,
                  labelColor: kPrimaryTextColor,
                  unselectedLabelStyle: Theme.of(context).textTheme.bodyText1,
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: kPrimaryColor,
                      width: 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: <Widget>[
                mHeightSpan,
                Expanded(
                  child: GetBuilder<CategoryItemSlugController>(
                      builder: (_categoryItemSlugController) =>
                          _categoryItemSlugController.isLoading
                              ? Center(child: CircularProgressIndicator())
                              : ListView.separated(
                                  padding: lPadding,
                                  itemCount: _categoryItemSlugController
                                      .categoryItemSlugModel.foods.length,
                                  separatorBuilder: (context, index) =>
                                      elHeightSpan,
                                  itemBuilder: (context, index) {
                                    return GetBuilder<CheckoutController>(
                                        builder: (checkoutController) {
                                      bool isAddedOnCart =
                                          checkoutController.isAddedOnCart(
                                              _categoryItemSlugController
                                                  .categoryItemSlugModel
                                                  .foods[index]
                                                  .sId);
                                      return MenuItemWidget(
                                        addToCart: () {
                                          final _food =
                                              _categoryItemSlugController
                                                  .categoryItemSlugModel
                                                  .foods[index];

                                          if (!isAddedOnCart) {
                                            CheckoutResponseModel
                                                checkoutResponseModel =
                                                CheckoutResponseModel(
                                              image: (_food.images != null &&
                                                      _food.images.isNotEmpty)
                                                  ? _food.images[0]
                                                  : null,
                                              sId: _categoryItemSlugController
                                                  .categoryItemSlugModel
                                                  .foods[index]
                                                  .sId,
                                              name: _categoryItemSlugController
                                                  .categoryItemSlugModel
                                                  .foods[index]
                                                  .name,
                                              slug: _categoryItemSlugController
                                                  .categoryItemSlugModel
                                                  .foods[index]
                                                  .slug,
                                              sellingPrice:
                                                  _categoryItemSlugController
                                                      .categoryItemSlugModel
                                                      .foods[index]
                                                      .sellingPrice,
                                              deliveryCharge:
                                                  _categoryItemSlugController
                                                      .categoryItemSlugModel
                                                      .foods[index]
                                                      .deliveryCharge,
                                            );
                                            checkoutController.addToCart(
                                                checkoutResponseModel);
                                            Get.snackbar("Item Added",
                                                "Item is added to Cart",
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                duration: Duration(seconds: 1));
                                          } else {
                                            Get.snackbar("Already Added",
                                                "Item is already Added on Cart",
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                duration: Duration(seconds: 1));
                                          }
                                        },
                                        foodItemSlugResponseModel:
                                            _categoryItemSlugController
                                                .categoryItemSlugModel
                                                .foods[index],
                                        isAdded: isAddedOnCart,
                                      );
                                    });
                                  },
                                )),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(
                  child: GetBuilder<CategoryItemSlugController>(
                    builder: (_categoryItemSlugController) =>
                        _categoryItemSlugController.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: _categoryItemSlugController
                                    .categoryItemSlugModel.reviews.length,
                                itemBuilder: (context, index) {
                                  final review = _categoryItemSlugController
                                      .categoryItemSlugModel.reviews[index];
                                  return ReviewWidget(review: review);
                                },
                              ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
