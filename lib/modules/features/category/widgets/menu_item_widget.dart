import 'package:bakery/common/logo_widget.dart';
import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/core/utils/image_url.dart';
import 'package:bakery/data_source/food/models/food_item_slug_response.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MenuItemWidget extends StatelessWidget {
  final FoodItemSlugResponseModel foodItemSlugResponseModel;
  final bool isAdded;
  final Function addToCart;

  const MenuItemWidget({
    @required this.foodItemSlugResponseModel,
    @required this.isAdded,
    @required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 84,
            child: Container(
              height: 75,
              width: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black12),
                image: DecorationImage(
                  image: (foodItemSlugResponseModel.images != null &&
                          foodItemSlugResponseModel.images.isNotEmpty)
                      ? NetworkImage(imageURLFormatter(
                          foodItemSlugResponseModel.images[0],
                        ))
                      : getLogoImage(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          mWidthSpan,
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        foodItemSlugResponseModel.name,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: kPrimaryTextColor,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text(
                            "\$${foodItemSlugResponseModel.sellingPrice}",
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: kSecondaryTextColor,
                                    ),
                          ),
                          esWidthSpan,
                          Text(
                            "\$${foodItemSlugResponseModel.markedPrice}",
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: kTertiaryTextColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              height: 32,
                              child: InkWell(
                                onTap: () {
                                  addToCart();
                                },
                                child: Container(
                                  padding: sXPadding,
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
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                sWidthSpan,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
