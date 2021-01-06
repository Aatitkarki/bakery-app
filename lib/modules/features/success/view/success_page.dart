import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/modules/features/orders/controller/order_controller.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessPage extends StatelessWidget {
  final OrderController orderController = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo/deliveryIcon.png",
              fit: BoxFit.fill,
            ),
            Text(
              "Your order is confirmed!",
              style:
                  Theme.of(context).textTheme.headline6.copyWith(fontSize: 24),
            ),
            sHeightSpan,
            Padding(
                padding: lPagePadding,
                child: GetBuilder<OrderController>(builder: (_controller) {
                  return _controller.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            backgroundColor: Colors.white30,
                          ),
                        )
                      : Text(
                          "${"orderController.orderSuccessModel.message"}",
                          style: Theme.of(context).textTheme.subtitle2,
                          textAlign: TextAlign.center,
                        );
                })),
            sHeightSpan,
            Container(
              height: 52,
              width: size.width * 0.5,
              padding: lPadding,
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "Check Order Status",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: kWhiteBackgroundColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
