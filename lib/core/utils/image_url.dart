import 'package:bakery/common/logo_widget.dart';
import 'package:bakery/core/config/http_config.dart';

String imageURLFormatter(String url) {
  if (url == null) return getLogoImageURL();

  if (url.contains("http")) {
    return url;
  }

  return HttpConfig.baseURL + url;
}
