import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/data_source/delivery/model/delivery_distance_response.dart';
import 'package:bakery/modules/features/checkout/controller/place_order_controller.dart';
import 'package:get/get.dart';

class OrderModal extends StatelessWidget {
  final bool isPickup;
  final List<DeliveryDistanceResponseModel> distances;

  final PlaceOrderController controller = Get.put(PlaceOrderController());

  OrderModal({Key key, this.isPickup = true, this.distances}) {
    controller.init(isPickup, distances);
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.subtitle1.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.black,
        );

    // if(isPickup) {
    //   // pickup -> add only note
    //   Get.bottomSheet(BottomSheetWrapper(child: ));
    // } else {
    //   // delivery -> add note + distance
    //
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mHeightSpan,
        Text("Phone Number", style: style),
        sHeightSpan,
        KOutlineTextField(controller: controller.phoneNumberController),
        mHeightSpan,
        Text("Order note", style: style),
        sHeightSpan,
        KOutlineTextField(
          maxLines: 5,
          minLines: 3,
          controller: controller.orderNoteController,
        ),
        mHeightSpan,
        if (!isPickup) Text("Distance", style: style),
        if (!isPickup) sHeightSpan,
        if (!isPickup)
          GetBuilder<PlaceOrderController>(
            builder: (PlaceOrderController controller) {
              return Container(
                padding: mXPadding,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                ),
                child: DropdownButton<DeliveryDistanceResponseModel>(
                  isDense: false,
                  underline: Container(),
                  isExpanded: true,
                  items: distances.map((e) {
                    return DropdownMenuItem<DeliveryDistanceResponseModel>(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(e.name), Text("\$${e.price}")],
                      ),
                      value: e,
                    );
                  }).toList(),
                  value: controller.chosen,
                  onChanged: controller.chooseDeliveryDistance,
                ),
              );
            },
          ),
        if (!isPickup) mHeightSpan,
        GetBuilder<PlaceOrderController>(
            builder: (PlaceOrderController controller) {
          return KButton(
            text: "Order",
            loading: controller.isLoading,
            onPressed: controller.requestOrder,
          );
        }),
      ],
    );
  }
}
