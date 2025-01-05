import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({super.email,super.bio,super.career,super.followerNumber,super.followers,
  super.following,super.followingNumber,super.name,super.profileUrl,super.uid,super.userName,
    super.postNumber
  });
  factory UserModel.fromDocSnapShot(DocumentSnapshot snapshot){
    Map data=snapshot.data()as Map<String,dynamic>;
    return UserModel(
      name: data["name"],
      bio: data["bio"],
      career: data["career"],
      email: data["email"],
      followerNumber: data["followerNumber"],
      followingNumber: data["followingNumber"],
      profileUrl: data["profileUrl"],
      uid: data["uid"],
      userName: data["userName"],
      postNumber: data["postNumber"],
      followers: List.from(snapshot.get("followers")),
      following: List.from(snapshot.get("following")),

    );
  }
  Map<String,dynamic>toJson(){
    return {
      "name": name,
      "bio": bio,
      "career": career,
      "email": email,
      "followerNumber": followerNumber,
      "followingNumber": followingNumber,
      "profileUrl": profileUrl,
      "uid": uid,
      "userName": userName,
      "followers": followers,
      "following": following
    };
  }

}