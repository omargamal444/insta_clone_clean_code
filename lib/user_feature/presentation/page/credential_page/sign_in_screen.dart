import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/auth_controller/sign_in_controller.dart';
import 'package:insta_clone/user_feature/presentation/page/credential_page/sign_up_screen.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  static const signInScreen = "/signInScreen";
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                sizBoxHeight(120),
                Center(
                    child: Text(
                  "instgram",
                  style: GoogleFonts.allison(
                      textStyle: const TextStyle(fontSize: 50)),
                )),
                sizBoxHeight(50),
                Stack(
                  children: [
                    const CircleAvatar(
                        radius: 30, child: Icon(Icons.account_circle_sharp)),
                    Positioned(
                        left: 20,
                        top: 25,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt_rounded)))
                  ],
                ),
                controller.isLoading
                    ? const SizedBox(
                        height: 200,
                        width: 50,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      )
                    : sizBoxHeight(150),
                TextFormField(
                  controller: controller.emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "this field cant be empty ***";
                    } else {
                      return null;
                    }
                  },
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 10, left: 20),
                      hintText: "email",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: whiteColor,
                              width: 2,
                              style: BorderStyle.solid))
                      //border: const OutlineInputBorder()
                      ),
                ),
                sizBoxHeight(25),
                TextFormField(
                  controller: controller.passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "this field cant be empty ***";
                    } else {
                      return null;
                    }
                  },
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 10, left: 20),
                      hintText: "password",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                              color: whiteColor,
                              width: 2,
                              style: BorderStyle.solid))
                      //border: const OutlineInputBorder()
                      ),
                ),
                sizBoxHeight(25),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await controller.signIn();
                    }
                  },
                  child: Container(
                    width: 350,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    child: const Center(child: Text("sign in")),
                  ),
                ),
                sizBoxHeight(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("already has an account?"),
                    TextButton(
                        onPressed: () {
                          Get.offNamed(SignUpScreen.signUpScreen);
                        },
                        child: const Text("signup"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
