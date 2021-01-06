import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/core/utils/image_url.dart';
import 'package:bakery/modules/features/gift_card/controller/gift_card_controller.dart';
import 'package:get/get.dart';

class GiftCardPage extends StatelessWidget {
  final GiftCardController _controller = Get.put(GiftCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gift Cards")),
      body: GetBuilder<GiftCardController>(
        builder: (GiftCardController _controller) {
          if (_controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_controller.hasFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _controller.failure,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  ),
                  sHeightSpan,
                  Container(
                    height: 36,
                    child: OutlineButton(
                      child: Text("Try Again"),
                      onPressed: _controller.getGiftCards,
                    ),
                  ),
                ],
              ),
            );
          }

          // return Container(
          //   height: 120,
          //   width: context.width,
          //   color: Colors.green,
          // );

          print(_controller.giftCards.length);

          return RefreshIndicator(
            onRefresh: () async {
              _controller.getGiftCards();
            },
            child: ListView.separated(
              padding: lPadding,
              itemCount: _controller.giftCards.length,
              separatorBuilder: (BuildContext context, int index) =>
                  sHeightSpan,
              itemBuilder: (BuildContext context, int index) {
                final card = _controller.giftCards[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120,
                        width: context.width,
                        child: Image.network(
                          imageURLFormatter(card.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: 36,
                        margin: mPadding,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text("  \$${card.price.toString()}"),
                            ),
                            mWidthSpan,
                            Expanded(
                              child: KButton(
                                text: "BUY",
                                loading: card.sId.compareTo(
                                        _controller.preauthorizing ?? "") ==
                                    0,
                                onPressed: () => _controller.buyGiftCard(card),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
