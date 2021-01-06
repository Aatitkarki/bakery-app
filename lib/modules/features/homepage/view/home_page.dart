import 'package:bakery/common/logo_widget.dart';
import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/core/utils/image_url.dart';
import 'package:bakery/data_source/checkout/models/checkout_response_model.dart';
import 'package:bakery/modules/features/category/controller/category_page_controller.dart';
import 'package:bakery/modules/features/checkout/controller/checkout_controller.dart';
import 'package:bakery/modules/features/checkout/view/checkout_page.dart';
import 'package:bakery/modules/features/homepage/controller/food_item_controller.dart';
import 'package:bakery/modules/features/homepage/widgets/food_item_info_widget.dart';

import 'package:bakery/modules/features/homepage/widgets/order_menu_widget.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final FoodItemController _foodItemController = Get.put(FoodItemController());
  final CheckoutController _checkoutController = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mHeightSpan,
            lHeightSpan,
            Container(
              padding: mXPadding,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 64,
                      alignment: Alignment.centerLeft,
                      child: KLogoWidget(),
                    ),
                    // child: TextField(
                    //   cursorColor: Colors.black,
                    //   decoration: InputDecoration(
                    //     suffixIcon: Icon(Icons.search),
                    //     hintText: "Search...",
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide.none,
                    //       borderRadius: BorderRadius.circular(48),
                    //     ),
                    //     filled: true,
                    //     contentPadding: mPadding,
                    //     fillColor: kPrimaryColor.withOpacity(0.1),
                    //   ),
                    // ),
                  ),
                  elWidthSpan,
                  Container(
                    child: Material(
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(48),
                        splashColor: kLightWhiteColor,
                        onTap: () => Get.to(CheckOutPage()),
                        child: Stack(
                          children: [
                            Padding(
                              padding: mPadding,
                              child: Icon(
                                Feather.shopping_cart,
                                color: kWhiteBackgroundColor,
                                size: 20,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 8.0,
                                child: CircleAvatar(
                                  backgroundColor: kPrimaryColor,
                                  radius: 7.0,
                                  child: GetBuilder<CheckoutController>(
                                    builder: (_checkoutController) => Text(
                                      _checkoutController
                                          .getLength()
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: kWhiteBackgroundColor,
                                            fontSize: 8.0,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(48),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.075),
                          spreadRadius: 4,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            mHeightSpan,
            Container(
              padding: mXPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello, guest",
                      style: Theme.of(context).textTheme.headline5),
                  esHeightSpan,
                  Text(
                    "What do you want to order?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              width: context.width,
              child: Center(child: FittedBox(child: OrderMenuWidget())),
            ),
            Container(
              padding: mPadding,
              child: Text(
                "Our Highlights",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            GetBuilder<FoodItemController>(
              builder: (_foodItemController) => Expanded(
                child: _foodItemController.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _foodItemController.hasFailure
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _foodItemController.failure,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                sHeightSpan,
                                Container(
                                  height: 36,
                                  child: OutlineButton(
                                    onPressed: () {
                                      _foodItemController.getFood();
                                      final CategoryPageController
                                          _categoryPageController = Get.find();
                                      _categoryPageController.getCategories();
                                    },
                                    child: Text("Try Again!"),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _foodItemController.foodItemModel.length,
                            padding: mXPadding,
                            separatorBuilder: (context, index) => mWidthSpan,
                            itemBuilder: (context, index) {
                              final item =
                                  _foodItemController.foodItemModel[index];
                              return Container(
                                padding: mPadding,
                                width: MediaQuery.of(context).size.width * 0.85,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.25),
                                  ),
                                  image: DecorationImage(
                                    fit: (item.images != null &&
                                            item.images.isNotEmpty)
                                        ? BoxFit.cover
                                        : BoxFit.contain,
                                    image: (item.images != null &&
                                            item.images.isNotEmpty)
                                        ? NetworkImage(imageURLFormatter(
                                            _foodItemController
                                                .foodItemModel[index]
                                                .images[0]))
                                        : getLogoImage(),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    GetBuilder<CheckoutController>(
                                      init: CheckoutController(),
                                      builder: (checkoutController) =>
                                          FoodItemInfoWidget(
                                        addToCart: () {
                                          if (!checkoutController.isAddedOnCart(
                                              _foodItemController
                                                  .foodItemModel[index].sId)) {
                                            final _food = _foodItemController
                                                .foodItemModel[index];

                                            CheckoutResponseModel
                                                checkoutResponseModel =
                                                CheckoutResponseModel(
                                              image: (_food.images != null &&
                                                      _food.images.isNotEmpty)
                                                  ? _food.images[0]
                                                  : null,
                                              sId: _food.sId,
                                              name: _food.name,
                                              slug: _food.slug,
                                              sellingPrice: _food.sellingPrice,
                                              deliveryCharge: _food.markedPrice,
                                            );
                                            checkoutController.addToCart(
                                                checkoutResponseModel);
                                            Get.snackbar("Item Added",
                                                "Item is Added to Cart",
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
                                        isAdded: checkoutController
                                            .isAddedOnCart(_foodItemController
                                                .foodItemModel[index].sId),
                                        foodItemResponseModel:
                                            _foodItemController
                                                .foodItemModel[index],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
              ),
            ),
            mHeightSpan,
          ],
        ),
      ),
    );
  }
}
