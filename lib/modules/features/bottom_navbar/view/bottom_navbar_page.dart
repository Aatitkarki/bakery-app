import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/modules/features/bottom_navbar/controller/bottom_navbar_page_controller.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class BottomNavbarPage extends StatelessWidget {
  final BottomNavbarController navbarController =
      Get.put(BottomNavbarController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          resizeToAvoidBottomInset: false,
          body: navbarController.currentPage,
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Feather.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Feather.shopping_bag),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Feather.gift),
                label: 'Gift Cards',
              ),
              BottomNavigationBarItem(
                icon: Icon(Feather.user),
                label: 'Profile',
              ),
            ],
            currentIndex: navbarController.currentIndex.value,
            selectedItemColor: kPrimaryColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: kPrimaryTextColor,
            onTap: navbarController.changePage,
          ),
        ));
  }
}
