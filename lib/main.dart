import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/home_page/home_page.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/data/data_repo/user_repo_impl/user_repo_impl.dart';
import 'package:insta_clone/user_feature/data/data_source/remote_data_source/remote_data_source_impl.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_binding/app_binding.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_binding/auth_binding.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_binding/main_binding.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/main_page.dart';
import 'package:insta_clone/user_feature/presentation/page/app_pages/profile_page/profile_page.dart';
import 'package:insta_clone/user_feature/presentation/page/credential_page/sign_up_screen.dart';
import 'package:insta_clone/user_feature/presentation/page/credential_page/sign_in_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("8888888888888888888888888888888888888888888");
   bool isLoggedIn(){
     if(FirebaseAuth.instance.currentUser?.uid==null){
     return false;
     }
     else{
       return true;
     }
   }
    return GetMaterialApp(
      initialRoute: isLoggedIn()?MainPage.mainPage:SignInScreen.signInScreen,
      initialBinding: MainBinding(),
      getPages: [
        GetPage(
            name: SignUpScreen.signUpScreen,
            page: () => const SignUpScreen(),
            binding: SignUpBinding()),
        GetPage(
          name: SignInScreen.signInScreen,
          page: () => const SignInScreen(),
          binding: SignInBinding()
        ),
        GetPage(
            name: MainPage.mainPage,
            page: () => const MainPage(),),
        GetPage(
            name: ProfilePage.profilePage,
            page: () => const ProfilePage(),
            //binding: ProfileBinding()
    ),
        GetPage(name:HomePage.homePage,
          page: () => const HomePage(),
          //binding: HomeBinding()
        )
      ],
      theme: ThemeData.dark(),
    );
  }
}
