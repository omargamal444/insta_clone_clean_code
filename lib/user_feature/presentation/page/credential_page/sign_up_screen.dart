import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/auth_controller/sign_up_controller.dart';

import 'package:insta_clone/user_feature/presentation/page/credential_page/sign_in_screen.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  static const signUpScreen = "/signUpScreen";

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
                sizBoxHeight(70),
                Center(
                    child: Text(
                  "instgram",
                  style: GoogleFonts.allison(
                      textStyle: const TextStyle(fontSize: 50)),
                )),
                sizBoxHeight(40),
                Stack(
                  children: [
                    Container(
                      width: 90,
                      height:90,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: controller.path == ""?
                      const Icon(Icons.account_circle_sharp):
                          Image.file(File(controller.path),
                          fit: BoxFit.cover,)

                      ),

                    Positioned(
                      left: 40,
                      top: 40,
                      child: IconButton(
                        onPressed: () async {
                          final imagePath = await controller.pickImage();
                          controller.path = imagePath;
                        },
                        icon: const Icon(Icons.camera_alt_rounded),
                      ),
                    )
                  ],
                ),
                sizBoxHeight(70),
                TextFormField(
                  readOnly: controller.isLoading,
                  controller: controller.nameController,
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
                      hintText: "name",
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
                  readOnly: controller.isLoading,
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
                  readOnly: controller.isLoading,
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
                TextFormField(
                  readOnly: controller.isLoading,
                  controller: controller.careerController,
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
                      hintText: "career",
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
                  onTap:controller.isLoading==false? () async {
                    if (formKey.currentState!.validate()) {
                      {
                        await controller.signUp();
                      }
                    }
                  }:null,
                  child: Container(
                    width: 330,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                    child: const Center(child: Text("sign up")),
                  ),
                ),
                controller.isLoading?const CircularProgressIndicator():
                sizBoxHeight(25),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("already has an account?"),
                          TextButton(
                              onPressed: () {
                                Get.offNamed(SignInScreen.signInScreen);
                              },
                              child: const Text("signIn"))
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
