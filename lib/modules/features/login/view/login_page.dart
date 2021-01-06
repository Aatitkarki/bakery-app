import 'package:bakery/common/logo_widget.dart';
import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/modules/features/login/controller/login_page_controller.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: lPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: context.width * 0.55,
                child: KLogoWidget(),
              ),
            ),
            mHeightSpan,
            GetBuilder<LoginController>(builder: (LoginController _controller) {
              return RaisedButton(
                color: kPrimaryColor,
                onPressed: _controller.googleLogin,
                child: _controller.isLoading
                    ? Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                              Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesome.google),
                              mWidthSpan,
                              Text(
                                "LOGIN WITH GOOGLE",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
