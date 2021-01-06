import 'package:bakery/common/k_round_icon_widget.dart';
import 'package:bakery/common/logo_widget.dart';
import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/data_source/category/models/category_item_reponse.dart';
import 'package:bakery/data_source/category/models/category_item_slug_response.dart';
import 'package:bakery/modules/features/category/controller/category_item_slug_controller.dart';
import 'package:bakery/modules/features/checkout/view/checkout_page.dart';
import 'package:bakery/modules/features/homepage/widgets/order_menu_widget.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class CustomAppBarWidget extends StatelessWidget {
  final CategoryItemSlugController controller;

  const CustomAppBarWidget({@required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: esPadding,
      color: kBackgroundColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 32),
          Padding(
            padding: lXPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: RoundIconWidget(
                    backgroundColor: kWhiteBackgroundColor,
                    iconData: Feather.arrow_left,
                    iconColor: kPrimaryColor,
                  ),
                ),
                Container(height: 64, child: KLogoWidget()),
                InkWell(
                  onTap: () => Get.to(CheckOutPage()),
                  child: RoundIconWidget(
                    backgroundColor: kWhiteBackgroundColor,
                    iconData: Feather.shopping_cart,
                    iconColor: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          sHeightSpan,
          Container(
            height: 120,
            child: FittedBox(child: OrderMenuWidget(off: true)),
          ),
          _buildDetailWidget(
            context,
            controller.categoryItemSlugModel,
          ),
        ],
      ),
    );
  }

  _buildDetailWidget(context, CategoryItemSlugResponseModel slugData) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: mPadding.copyWith(
          right: lPadding.right,
          left: lPadding.right,
        ),
        decoration: BoxDecoration(
          color: kWhiteBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${slugData.name}",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: kPrimaryTextColor,
                        ),
                  ),
                  sHeightSpan,
                  Text(
                    '${slugData.tagline}',
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: kSecondaryTextColor,
                        ),
                  ),
                  sHeightSpan,
                ],
              ),
            ),
            mWidthSpan,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Feather.star,
                  color: kSecondaryIconColor,
                ),
                esWidthSpan,
                Text(
                  "${slugData.averageRating}",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ],
        ),
      );
}
