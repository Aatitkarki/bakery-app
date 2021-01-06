import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/data_source/order/models/order_response_model.dart';
import 'package:bakery/modules/features/review/controller/review_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ReviewPage extends StatelessWidget {
  final OrderResponseModel order;

  final ReviewController _controller = Get.put(ReviewController());

  ReviewPage({Key key, @required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Review")),
      body:
          GetBuilder<ReviewController>(builder: (ReviewController _controller) {
        return Stack(
          children: [
            Container(
              width: context.width,
              height: context.height,
              child: ListView(
                padding: lPadding.copyWith(
                  bottom: 96,
                ),
                children: [
                  mHeightSpan,
                  Text(
                    "Rating",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  sHeightSpan,
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: _controller.updateRating,
                  ),
                  mHeightSpan,
                  Text(
                    "Review",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  esHeightSpan,
                  KOutlineTextField(
                    hintText: "Add your review here",
                    controller: _controller.kReviewTextController,
                    minLines: 5,
                    maxLines: 8,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 12,
              right: 12,
              left: 12,
              child: KButton(
                text: "Add Review",
                loading: _controller.isLoading,
                onPressed: () => _controller.addReview(order),
              ),
            ),
          ],
        );
      }),
    );
  }
}
