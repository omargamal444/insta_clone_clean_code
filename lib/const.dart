import 'package:flutter/material.dart';

sizBoxHeight(double height) {
  return SizedBox(height: height);
}

sizBoxWidth(double width) {
  return SizedBox(width: width);
}

const whiteColor = Colors.white;

class Routes {
  static const signUpScreen = "/signup";
  static const signInScreen = "/signin";
}

class FirebaseConst {
  static const userCollection = "User";
  static const postCollection="post";
  static const email="email";
  static const password="password";
  static const career="career";
  static const name="name";
  static const userName="userName";
  static const postDescription="description";
  static const profileUrl="profileUrl";
  static const postImageUrl="postImageUrl";
  static const followerNumber="followerNumber";
  static const followingNumber="followingNumber";
  static const bio="bio";
  static const uid="uid";
  static const followers ="followers";
  static const following="following";
  static const createdAt="createdAt";
  static const commentNumber="commentNumber";
  static const likes="likes";
  static const likeNumber="likeNumber";
  static const postId="postId";
  static const creatorId="creatorId";
}




