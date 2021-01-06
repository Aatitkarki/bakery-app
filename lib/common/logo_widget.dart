import 'package:bakery/common/ui/ui_helper.dart';

class KLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://latables.netlify.app/demos/restaurant/images/logo@2x.png",
      fit: BoxFit.cover,
    );
  }
}

NetworkImage getLogoImage() {
  return NetworkImage(
      "https://latables.netlify.app/demos/restaurant/images/logo@2x.png");
}

String getLogoImageURL() =>
    "https://latables.netlify.app/demos/restaurant/images/logo@2x.png";
