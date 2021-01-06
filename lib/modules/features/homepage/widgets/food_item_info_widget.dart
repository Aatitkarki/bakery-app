import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/data_source/food/models/food_item_response.dart';
import 'package:bakery/modules/features/homepage/controller/food_item_controller.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class FoodItemInfoWidget extends StatelessWidget {
  final Function addToCart;
  final FoodItemResponseModel foodItemResponseModel;
  final bool isAdded;

  const FoodItemInfoWidget(
      {@required this.addToCart, this.foodItemResponseModel, this.isAdded});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: mPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${foodItemResponseModel.name}",
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.w500, color: kPrimaryTextColor),
            ),
            // Text(
            //   "${foodItemResponseModel.slug}",
            //   style: Theme.of(context).textTheme.subtitle2.copyWith(
            //       fontWeight: FontWeight.normal, color: kSecondaryTextColor),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "\$${foodItemResponseModel.sellingPrice.toString()}",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    esWidthSpan,
                    if (foodItemResponseModel?.markedPrice != null)
                      Text(
                        "\$${foodItemResponseModel.markedPrice.toString()}",
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.w500),
                      ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    addToCart();
                  },
                  child: Container(
                    padding: esPadding,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: Row(
                      children: [
                        Icon(
                          isAdded ? Feather.check : Feather.plus,
                          color: Colors.white,
                        ),
                        Icon(
                          Feather.shopping_cart,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
