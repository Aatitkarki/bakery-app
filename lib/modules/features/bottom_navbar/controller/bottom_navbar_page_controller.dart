import 'package:bakery/core/models/app_user_state.dart';
import 'package:bakery/modules/features/checkout/view/checkout_page.dart';
import 'package:bakery/modules/features/gift_card/view/gift_card_page.dart';
import 'package:bakery/modules/features/homepage/view/home_page.dart';
import 'package:bakery/modules/features/login/view/login_page.dart';
import 'package:bakery/modules/features/orders/view/orders_page.dart';
import 'package:bakery/modules/features/profile/view/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavbarController extends GetxController {
  final currentIndex = 0.obs;

  List<Widget> widgetsOptions = <Widget>[
    HomePage(),
    OrdersPage(), GiftCardPage(),

    // Center(
    //   child: Text("Page 3"),
    // ),
    ProfilePage(),
  ];
  Widget get currentPage => widgetsOptions[currentIndex.value];

  void changePage(int index) {
    if (index != 0 && !AppUserState().isLoggedIn) {
      Get.bottomSheet(LoginPage());
    } else {
      currentIndex.value = index;
    }
  }
}
