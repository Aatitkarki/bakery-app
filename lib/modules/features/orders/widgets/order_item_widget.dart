import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/core/utils/image_url.dart';
import 'package:bakery/data_source/order/models/order_response_model.dart';

import 'package:get/get.dart';

final _style = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

class OrderItemWidget extends StatefulWidget {
  final OrderResponseModel order;
  final Widget actions;

  const OrderItemWidget({Key key, @required this.order, this.actions})
      : super(key: key);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    String text = "";
    Color color = Colors.black;

    switch (widget.order.decodedStatus) {
      case OrderStatus.PENDING_PAYMENT:
        text = "Pre authorize order"; // user has not pre authorized yet
        color = Colors.orangeAccent;
        break;
      case OrderStatus.PAID_REQUIRE_CONFIRMATION:
        text = "Pending confirmation from chef";
        color = Colors.orangeAccent;
        break;
      case OrderStatus.PAID_CONFIRMED:
        text = "Order Confirmed - Cooking";
        color = Colors.orangeAccent;
        break;
      case OrderStatus.CANCELLED:
        text = "Order Cancelled";
        color = Colors.red;
        break;
      case OrderStatus.PAYMENT_RECEIVE_FAILED:
        text = "Pre authorization failed";
        color = Colors.red;
        break;
      case OrderStatus.COMPLETED:
        text = "Order completed";
        color = Colors.green;
        break;
      case OrderStatus.COOKED:
        text = "Order Cooked";
        color = Colors.green;
        break;
    }

    return Card(
      child: Padding(
        padding: lPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.order.addressNote +
                            "\n" +
                            widget.order.status),
                        sHeightSpan,
                        Text(
                          text,
                          style: _style.copyWith(color: color),
                        ),
                        widget.actions ?? SizedBox.shrink(),
                      ],
                    ),
                  ),
                  sWidthSpan,
                  IconButton(
                    icon: Icon(_expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down),
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                  ),
                ],
              ),
            ),
            if (_expanded) Divider(),
            if (_expanded)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sHeightSpan,
                  Text(
                    "Foods",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  mHeightSpan,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.order.foods.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 64,
                              width: context.width,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 96,
                                    color: Colors.white,
                                    child: Image.network(
                                      imageURLFormatter(e.images[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                                separatorBuilder: (_, __) => esWidthSpan,
                                itemCount: e.images.length,
                              ),
                            ),
                            esHeightSpan,
                            Text(e.name),
                            Text(
                              e.quantity.toString() + " items ordered",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
