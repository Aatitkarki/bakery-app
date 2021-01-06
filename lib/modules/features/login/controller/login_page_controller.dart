import 'package:bakery/common/ui/k_toast.dart';
import 'package:bakery/core/dependency_injection/injection.dart';
import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/core/models/app_user_state.dart';
import 'package:bakery/core/models/base_page_controller.dart';
import 'package:bakery/data_source/auth/models/login_request.dart';
import 'package:bakery/data_source/auth/models/login_response.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/modules/data/auth_repo.dart';
import 'package:bakery/modules/features/bottom_navbar/view/bottom_navbar_page.dart';
import 'package:bakery/modules/features/splash/view/splash_page.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends BasePageController {
  Log log = Log("LoginController");

  AppUserState appUserState;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final IAuthRepo _authRepo = injection<IAuthRepo>();

  @override
  void onInit() {
    appUserState = AppUserState();
    super.onInit();
  }

  Future googleLogin() async {
    try {
      _googleSignIn.disconnect();
      GoogleSignInAccount _account = await _googleSignIn.signIn();
      GoogleSignInAuthentication _authentication =
          await _account.authentication;

      setLoading(true);

      final result = await _authRepo.login(
        LoginRequestModel(token: _authentication.idToken),
      );

      result.fold(
        (NetworkFailure e) => KToast.e(e.message),
        (LoginResponseModel response) async {
          KToast.s("Logged In Successfully");
          setLoading(false);

          AppUserState().saveUser(response);

          // TODO
          // await _notificationService.init();
          // await _notificationService.subscribe(response.user.id);

          Future.delayed(Duration(milliseconds: 200), () {
            Get.back();
          });
        },
      );
      setLoading(false);
    } catch (e) {
      log.d(e.toString());
    }
  }
}
