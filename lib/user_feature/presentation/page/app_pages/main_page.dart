import 'package:flutter/material.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/add_post_page/add_post_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/favourite_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/home_page/home_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/profile_page/profile_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const mainPage = "/mainScreen";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List _pages = [
    const HomePage(),
    const SearchPage(),
    const AddPostPage(),
    const FavouritePage(),
    const ProfilePage()
  ];

  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: Icon(Icons.add_circle_outline, color: whiteColor), label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: whiteColor), label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded, color: whiteColor),
            label: ""),
      ], currentIndex: _currentIndex, onTap: _onTap),
      body: _pages[_currentIndex],
    );
  }
}
