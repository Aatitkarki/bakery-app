import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/data_source/order/models/order_response_model.dart';
import 'package:bakery/modules/features/orders/controller/order_controller.dart';
import 'package:bakery/modules/features/orders/widgets/order_item_widget.dart';
import 'package:get/get.dart';

class OrdersPage extends StatelessWidget {
  final OrderController _controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Orders")),
      body: GetBuilder<OrderController>(
        builder: (_controller) {
          return _body(_controller);
        },
      ),
    );
  }

  final _style = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  _body(OrderController _controller) {
    if (_controller.isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (_controller.hasFailure) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_controller.failure),
            sHeightSpan,
            Container(
              height: 36,
              child: OutlineButton(
                onPressed: _controller.getOrders,
                child: Text("Load"),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await _controller.getOrders();
      },
      child: ListView.separated(
        padding: mPadding,
        itemCount: _controller.orderResponseList.length,
        separatorBuilder: (_, __) => sHeightSpan,
        itemBuilder: (context, index) {
          final _order = _controller.orderResponseList[index];

          bool _showPay = _order.decodedStatus == OrderStatus.PENDING_PAYMENT ||
              _order.decodedStatus == OrderStatus.PAYMENT_RECEIVE_FAILED;

          return OrderItemWidget(
            order: _order,
            actions: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_showPay)
                  Container(
                    margin: sYPadding,
                    height: 36,
                    child: Row(
                      children: [
                        Expanded(
                          child: KButton(
                            text: "Pay",
                            loading: _order.sId.compareTo(
                                    _controller?.preauthorizing ?? "") ==
                                0,
                            onPressed: () {
                              _controller.onPayPressed(_order);
                            },
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                if (_order?.canReview ?? false)
                  Container(
                    margin: sYPadding,
                    height: 36,
                    child: Row(
                      children: [
                        Expanded(
                          child: KButton(
                            text: "Review",
                            loading: _order.sId
                                    .compareTo(_controller?.reviewing ?? "") ==
                                0,
                            onPressed: () {
                              _controller.onReviewPressed(_order);
                            },
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
