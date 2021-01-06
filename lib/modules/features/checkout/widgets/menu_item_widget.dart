import 'package:bakery/common/logo_widget.dart';
import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/core/utils/image_url.dart';
import 'package:bakery/data_source/checkout/models/checkout_response_model.dart';
import 'package:bakery/modules/features/category/widgets/rectangular_icon_widget.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MenuItemWidget extends StatelessWidget {
  final CheckoutResponseModel checkoutResponseModel;

  final Function increaseItem;
  final Function decreaseItem;
  final Function removeItem;

  const MenuItemWidget({
    @required this.checkoutResponseModel,
    @required this.increaseItem,
    @required this.decreaseItem,
    this.removeItem,
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
                image: DecorationImage(
                  image: NetworkImage(
                    imageURLFormatter(checkoutResponseModel.image),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          mWidthSpan,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${checkoutResponseModel.name}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    color: kPrimaryTextColor,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${checkoutResponseModel.sellingPrice}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
                                        color: kSecondaryTextColor,
                                      ),
                                ),
                                sWidthSpan,
                                Text(
                                  "${checkoutResponseModel.markedPrice}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
                                        color: kTertiaryTextColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      sWidthSpan,
                      Container(
                        child: Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(48),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(48),
                            splashColor: kLightWhiteColor,
                            onTap: () {
                              removeItem();
                            },
                            child: Padding(
                              padding: sPadding,
                              child: Icon(
                                Icons.delete,
                                color: kPrimaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: kWhiteBackgroundColor,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 32,
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            child: Material(
                              color: kLightWhiteColor,
                              child: InkWell(
                                onTap: () {
                                  decreaseItem();
                                },
                                splashColor: kLightWhiteColor,
                                child: Center(
                                  child: Icon(
                                    Feather.minus,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                bottomLeft: Radius.circular(4),
                              ),
                            ),
                          ),
                          RectangularIconWidget(
                            height: 36,
                            child: Center(
                                child:
                                    Text("${checkoutResponseModel.itemCount}")),
                            color: kPrimaryColorLight,
                          ),
                          Container(
                            width: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                            ),
                            child: Material(
                              color: kPrimaryColor,
                              child: InkWell(
                                splashColor: kLightWhiteColor,
                                onTap: () {
                                  increaseItem();
                                },
                                child: Center(
                                  child: Icon(
                                    Feather.plus,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
