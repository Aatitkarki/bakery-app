import 'package:bakery/common/ui/ui_helper.dart';

class BottomSheetWrapper extends StatelessWidget {
  final Widget child;

  const BottomSheetWrapper({Key key, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: MediaQuery.of(context).size.height * 0.85,
      duration: Duration(milliseconds: 200),
      // padding: EdgeInsets.only(
      //     // bottom: MediaQuery.of(context).viewInsets.bottom,
      //     ),
      child: Container(
        margin: sPadding,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              spreadRadius: 4,
              color: Colors.black.withOpacity(0.075),
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            sHeightSpan,
            sHeightSpan,
            Center(
              child: Container(
                width: 72,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            lHeightSpan,
            Expanded(
              child: Container(
                padding: lXPadding.copyWith(
                  bottom: lXPadding.right,
                ),
                child: SingleChildScrollView(
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
