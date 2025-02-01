import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_binding/main_binding.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/add_post_page/add_post_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/comment_page/comment_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/home_page/home_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/main_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/post_detail_page/post_detail_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/profile_page/profile_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/search_page/search_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/search_page/searched_user_profile_page.dart';
import 'package:insta_clone/user_feature/presentation/page/credential_page/sign_in_screen.dart';
import 'package:insta_clone/user_feature/presentation/page/credential_page/sign_up_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn() {
      if (FirebaseAuth.instance.currentUser?.uid == null) {
        return false;
      } else {
        return true;
      }
    }

    return GetMaterialApp(
      initialRoute:
          isLoggedIn() ? MainPage.mainPage : SignInScreen.signInScreen,
      initialBinding: MainBinding(),
      getPages: [
        GetPage(
            name: SignUpScreen.signUpScreen,
            page: () => const SignUpScreen(),
        ),
        GetPage(
            name: SignInScreen.signInScreen,
            page: () => const SignInScreen(),
        ),
        GetPage(
          name: MainPage.mainPage,
          page: () => const MainPage(),
        ),
        GetPage(
          name: ProfilePage.profilePage,
          page: () => const ProfilePage(),
          //binding: ProfileBinding()
        ),
        GetPage(
          name: HomePage.homePage,
          page: () => const HomePage(),
          //binding: HomeBinding()
        ),
        GetPage(
          name: AddPostPage.addPostPage,
          page: () => const AddPostPage(),
          //binding:AddPostBinding()
        ),
        GetPage(
          name: CommentPage.commentPage,
          page: () => const CommentPage(),
        ),
        GetPage(
          name: SearchPage.searchPage,
          page: () => const SearchPage(),
        ),
        GetPage(
          name: SearchedUserProfilePage.searchedUserProfilePage,
          page: () => const SearchedUserProfilePage(),
        ),
        GetPage(
          name: PostDetailPage.postDetailPage,
          page: () => const PostDetailPage(),
        ),
      ],
      theme: ThemeData.dark(),
    );
  }
}
