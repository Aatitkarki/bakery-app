import 'package:bakery/common/ui/k_toast.dart';
import 'package:bakery/core/dependency_injection/injection.dart';
import 'package:bakery/core/logger/logger.dart';
import 'package:bakery/core/models/app_user_state.dart';
import 'package:bakery/core/models/base_page_controller.dart';
import 'package:bakery/data_source/auth/models/login_request.dart';
import 'package:bakery/data_source/auth/models/login_response.dart';
import 'package:bakery/data_source/models/network_failure.dart';
import 'package:bakery/modules/data/auth_repo.dart';
import 'package:bakery/modules/data/profile_repo.dart';
import 'package:bakery/modules/features/bottom_navbar/view/bottom_navbar_page.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileController extends BasePageController {
  Log log = Log("ProfileController");

  final IProfileRepo _profileRepo = injection<IProfileRepo>();

  @override
  void onInit() {
    getMyProfile();
    super.onInit();
  }

  LoginUserResponseModel _profile;
  LoginUserResponseModel get profile => _profile;

  Future getMyProfile() async {
    setFailure();
    setLoading(true);
    final result = await _profileRepo.getMyProfile();

    result.fold(
      (NetworkFailure e) => setFailure(e.message),
      (LoginUserResponseModel response) async {
        _profile = response;
        setLoading(false);
      },
    );
    setLoading(false);
  }
}
