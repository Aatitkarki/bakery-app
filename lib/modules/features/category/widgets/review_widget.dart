import 'package:bakery/common/logo_widget.dart';
import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/data_source/category/models/review_success_model.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewSuccessModel review;

  const ReviewWidget({Key key, @required this.review}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: lXPadding,
      margin: lYPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: (review?.customer?.image != null)
                ? NetworkImage(review.customer.image)
                : getLogoImage(),
          ),
          mWidthSpan,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review?.customer?.name ?? "Customer",
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: kPrimaryTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                esHeightSpan,
                Text(
                  review.review ?? "",
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: kPrimaryTextColor,
                        fontWeight: FontWeight.w300,
                      ),
                ),
              ],
            ),
          ),
          sWidthSpan,
          Row(
            children: [
              Icon(
                Feather.star,
                color: kSecondaryIconColor,
              ),
              esWidthSpan,
              Text(
                (review?.rating ?? 0).toString(),
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
