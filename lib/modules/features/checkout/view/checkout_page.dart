import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/modules/features/checkout/controller/checkout_controller.dart';
import 'package:bakery/modules/features/checkout/widgets/item_value_widget.dart';
import 'package:bakery/modules/features/checkout/widgets/menu_item_widget.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutPage extends StatelessWidget {
  final CheckoutController checkoutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhiteBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
          color: kPrimaryColor,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.replay,
              color: Colors.black,
            ),
            onPressed: checkoutController.loadData,
          ),
        ],
        title: Text(
          "Checkout",
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            physics: BouncingScrollPhysics(),
            padding: mPadding,
            children: [
              _pickUpOrHomeDeliver(context),
              mHeightSpan,
              _myBucketSection(context),
              elHeightSpan,
              elHeightSpan,
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: lPadding,
              decoration: BoxDecoration(
                color: kWhiteBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -2),
                    color: Colors.black12,
                    blurRadius: 16,
                  ),
                ],
              ),
              child: GetBuilder<CheckoutController>(
                builder: (checkoutController) {
                  return GestureDetector(
                    onTap: checkoutController.placeOrder,
                    child: Container(
                      height: 64,
                      padding: lPadding,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: kPrimaryColor,
                      ),
                      child: checkoutController.gettingDistance
                          ? Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Checkout",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(color: kWhiteBackgroundColor),
                                ),
                                Text(
                                  "\$ ${checkoutController.totalAmount()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(color: kWhiteBackgroundColor),
                                )
                              ],
                            ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _pickUpOrHomeDeliver(context) {
    return GetBuilder<CheckoutController>(builder: (checkoutController) {
      return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, bottom: 8),
              child: Text(
                "Choose delivery option",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontSize: 22),
              ),
            ),
            RadioListTile(
              value: "pickup",
              groupValue: checkoutController.deliverOption,
              onChanged: checkoutController.changeDeliveryOption,
              title: Text("Pick Up"),
            ),
            // mHeightSpan,
            RadioListTile(
              value: "home",
              groupValue: checkoutController.deliverOption,
              onChanged: checkoutController.changeDeliveryOption,
              title: Text("Home Delivery"),
            ),
          ],
        ),
      );
    });
  }

  _deliverToSection(BuildContext context) => Container(
        padding: mPadding,
        decoration: BoxDecoration(
            color: kWhiteBackgroundColor,
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Deliver to",
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.w500, color: kSecondaryTextColor),
                ),
                Icon(
                  Icons.radio_button_checked,
                  color: kPrimaryColor,
                ),
              ],
            ),
            sHeightSpan,
            TextField(
              controller: checkoutController.addressTextController,
              cursorColor: Colors.black,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: kPrimaryTextColor.withOpacity(1),
                  ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.book),
                hintText: "Add a note of delivery address",
                hintStyle: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: kPrimaryTextColor.withOpacity(0.6),
                    ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(4),
                ),
                filled: true,
                contentPadding: lPadding,
                fillColor: kLightGreyColor,
              ),
            ),
          ],
        ),
      );

  _myBucketSection(BuildContext context) => Container(
        padding: mPadding,
        decoration: BoxDecoration(
          color: kWhiteBackgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Bucket",
              style:
                  Theme.of(context).textTheme.headline5.copyWith(fontSize: 22),
            ),
            mHeightSpan,
            GetBuilder<CheckoutController>(
              builder: (context) {
                return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        checkoutController.checkoutResponseModelList.length,
                    separatorBuilder: (_, __) => mHeightSpan,
                    itemBuilder: (context, index) {
                      return MenuItemWidget(
                        checkoutResponseModel:
                            checkoutController.checkoutResponseModelList[index],
                        increaseItem: () {
                          checkoutController.increaseCartItem(
                              checkoutController
                                  .checkoutResponseModelList[index],
                              index);
                        },
                        decreaseItem: () {
                          checkoutController.checkoutResponseModelList[index]
                                      .itemCount >
                                  1
                              ? checkoutController.decreaseCartItem(
                                  checkoutController
                                      .checkoutResponseModelList[index])
                              : Get.defaultDialog(
                                  title: "Delete Item",
                                  textConfirm: "Yes",
                                  confirmTextColor: kWhiteBackgroundColor,
                                  buttonColor: kPrimaryColor,
                                  onConfirm: () {
                                    checkoutController.removeItem(
                                        checkoutController
                                            .checkoutResponseModelList[index]);
                                    Get.back();
                                    Get.snackbar("Item removed",
                                        "Item has been successfully removed",
                                        snackPosition: SnackPosition.BOTTOM);
                                  },
                                  textCancel: "No",
                                  cancelTextColor: kPrimaryColor,
                                  middleText:
                                      "Do you want to remove item from checkout?",
                                  middleTextStyle:
                                      Theme.of(context).textTheme.bodyText2

                                  //title: "Remove Item"
                                  );
                        },
                        removeItem: () {
                          Get.defaultDialog(
                              title: "Delete Item",
                              textConfirm: "Yes",
                              confirmTextColor: kWhiteBackgroundColor,
                              buttonColor: kPrimaryColor,
                              onConfirm: () {
                                checkoutController.removeItem(checkoutController
                                    .checkoutResponseModelList[index]);
                                Get.back();
                                Get.snackbar("Item removed",
                                    "Item has been successfully removed",
                                    snackPosition: SnackPosition.BOTTOM);
                              },
                              textCancel: "No",
                              cancelTextColor: kPrimaryColor,
                              middleText:
                                  "Do you want to remove item from checkout?",
                              middleTextStyle:
                                  Theme.of(context).textTheme.bodyText2

                              //title: "Remove Item"
                              );
                        },
                      );
                    });
              },
            ),
          ],
        ),
      );

  _paymentSection(BuildContext context) => Container(
        padding: mPadding,
        decoration: BoxDecoration(
            color: kWhiteBackgroundColor,
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment",
              style:
                  Theme.of(context).textTheme.headline5.copyWith(fontSize: 22),
            ),
            mHeightSpan,
            ItemValueWidget(
              title: "Item total",
              value: "\$ 18.500",
              titleTextStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: kPrimaryTextColor, fontWeight: FontWeight.w400),
              valueTextStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: kPrimaryTextColor,
                  ),
            ),
            sHeightSpan,
            ItemValueWidget(
              title: "Delivery Fee",
              value: "\$ 0",
              titleTextStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: kPrimaryTextColor, fontWeight: FontWeight.w400),
              valueTextStyle: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: kPrimaryTextColor),
            ),
            sHeightSpan,
            Container(
              height: 2,
              color: kDividerColor,
              width: double.infinity,
            ),
            sHeightSpan,
            ItemValueWidget(
              title: "To Pay",
              value: "\$ 18.500",
              titleTextStyle: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: kPrimaryTextColor),
              valueTextStyle: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: kPrimaryTextColor),
            )
          ],
        ),
      );
}
