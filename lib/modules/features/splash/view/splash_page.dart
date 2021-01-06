import 'package:bakery/common/logo_widget.dart';
import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/modules/features/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  final SplashController _splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          child: KLogoWidget(),
        ),
      ),
    );
  }
}
