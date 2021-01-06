import 'package:bakery/core/dependency_injection/injection.dart';
import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/core/models/app_user_state.dart';
import 'package:bakery/core/models/base_page_controller.dart';
import 'package:bakery/core/services/push_notification_service.dart';
import 'package:bakery/data_source/auth/models/login_response.dart';
import 'package:bakery/modules/features/bottom_navbar/view/bottom_navbar_page.dart';
import 'package:bakery/modules/features/login/view/login_page.dart';
import 'package:get/get.dart';

class SplashController extends BasePageController {
  Log log = Log("SplashController");

  AppUserState appUserState;
  final PushNotificationService _notificationService =
      injection<PushNotificationService>();

  @override
  void onInit() {
    _notificationService.initialise();
    appUserState = AppUserState();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    appUserState.retrieveUser();

    await Future.delayed(Duration(milliseconds: 1200));

    if (appUserState.isLoggedIn) {
      _notificationService.initialise(appUserState.user.user.id);
    }

    Get.offAll(BottomNavbarPage());
  }
}
