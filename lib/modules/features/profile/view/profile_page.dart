import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/core/models/app_user_state.dart';
import 'package:bakery/modules/features/gift_card/view/my_gift_card.dart';
import 'package:bakery/modules/features/login/view/login_page.dart';
import 'package:bakery/modules/features/profile/controller/profile_page_controller.dart';
import 'package:bakery/modules/features/splash/view/splash_page.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: GetBuilder<ProfileController>(
          builder: (ProfileController _controller) {
        if (_controller.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (_controller.hasFailure || _controller.profile == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _controller.failure ?? "Profile not loaded",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                sHeightSpan,
                Container(
                  height: 36,
                  child: OutlineButton(
                    onPressed: _controller.getMyProfile,
                    child: Text("Try Again!"),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            _controller.getMyProfile();
          },
          child: ListView(
            padding: mPadding,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: Container(
                      width: 72,
                      height: 72,
                      child: Image.network(
                        _controller.profile.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  mWidthSpan,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_controller.profile.name),
                        esHeightSpan,
                        Text(_controller.profile.email),
                        sHeightSpan,
                      ],
                    ),
                  ),
                ],
              ),
              lHeightSpan,
              Container(
                height: 36,
                child: OutlineButton(
                  onPressed: () {
                    Get.to(MyGiftCardPage());
                  },
                  child: Text("View Gift Cards"),
                ),
              ),
              mHeightSpan,
              KButton(
                text: "Logout",
                onPressed: () {
                  AppUserState().clear();
                  _controller.setFailure("Login to view profile");
                  Get.bottomSheet(LoginPage());
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
