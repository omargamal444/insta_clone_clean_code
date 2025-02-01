import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/main_page_controller.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/add_post_page/add_post_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/home_page/home_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/profile_page/profile_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/search_page/search_page.dart';

class MainPage extends GetView<MainPageController> {
  static const mainPage = "/mainScreen";

  const MainPage({super.key});

  void _onTap(int index) {
    controller.currentIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    final List pages = [
      const HomePage(),
      const SearchPage(),
      const AddPostPage(),
      const ProfilePage(),
    ];
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                color: whiteColor,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: whiteColor,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline, color: whiteColor),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded, color: whiteColor),
              label: ""),
        ], currentIndex: controller.currentIndex, onTap: _onTap),
        body: pages[controller.currentIndex],
      ),
    );
  }
}
