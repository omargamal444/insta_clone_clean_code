import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({super.email,
    super.bio,super.career,
    super.followerNumber,
    super.followers,
  super.following,
    super.followingNumber,
    super.name,
    super.profileUrl,
    super.uid,
    super.userName,
    super.postNumber
  });
  factory UserModel.fromDocSnapShot(Map<String,dynamic>snapshot){
    return UserModel(
      name: snapshot[FirebaseConst.name],
      bio: snapshot[FirebaseConst.bio],
      career: snapshot[FirebaseConst.career],
      email: snapshot[FirebaseConst.email],
      followerNumber: snapshot[FirebaseConst.followerNumber],
      followingNumber: snapshot[FirebaseConst.followingNumber],
      profileUrl: snapshot[FirebaseConst.profileUrl],
      uid: snapshot[FirebaseConst.uid],
      userName: snapshot[FirebaseConst.userName],
      postNumber: snapshot[FirebaseConst.postNumber],
      followers: List.from(snapshot[FirebaseConst.followers]),
      following: List.from(snapshot[FirebaseConst.following]),

    );
  }
  Map<String,dynamic>toJson(){
    return {
      FirebaseConst.name: name,
      FirebaseConst.bio: bio,
      FirebaseConst.career: career,
      FirebaseConst.email: email,
      FirebaseConst.followerNumber: followerNumber,
      FirebaseConst.followingNumber: followingNumber,
      FirebaseConst.profileUrl: profileUrl,
      FirebaseConst.uid: uid,
      FirebaseConst.userName: userName,
      FirebaseConst.followers: followers,
      FirebaseConst.following: following,
      FirebaseConst.postNumber:postNumber
    };
  }

}