import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';

class PostModel extends PostEntity {
  PostModel(
      {super.name,
      super.commentNumber,
      super.createdAt,
      super.creatorId,
      super.description,
      super.likeNumber,
      super.likes,
      super.postId,
      super.postImageUrl,
      super.profileImage,
      super.userName});

  factory PostModel.fromDocSnapShot(Map<String, dynamic> data) {
    return PostModel(
        name: data[FirebaseConst.name],
        userName: data[FirebaseConst.userName],
        commentNumber: data[FirebaseConst.commentNumber],
        createdAt: data[FirebaseConst.createdAt],
        creatorId: data[FirebaseConst.creatorId],
        description: data[FirebaseConst.postDescription],
        likeNumber: data[FirebaseConst.likeNumber],
        likes: data[FirebaseConst.likes],
        postId: data[FirebaseConst.postId],
        postImageUrl: data[FirebaseConst.postImageUrl],
        profileImage: data[FirebaseConst.profileUrl]);
  }

  Map<String, dynamic> toJson() {
    return {
      FirebaseConst.name: name,
      FirebaseConst.createdAt: createdAt,
      FirebaseConst.creatorId: creatorId,
      FirebaseConst.postId: postId,
      FirebaseConst.postImageUrl: postImageUrl,
      FirebaseConst.userName: userName,
      FirebaseConst.likes: likes,
      FirebaseConst.profileUrl: profileImage,
      FirebaseConst.likeNumber: likeNumber,
      FirebaseConst.postDescription: description,
      FirebaseConst.commentNumber: commentNumber
    };
  }
 printString(){
    return "name:$name,userName:$userName,likes:$likes"
        "description:$description},commentNumber:$commentNumber"
        "likeNumber:$likeNumber"
            "profileUrl:$profileImage,postImageUrl:$postImageUrl"
        "postId:$postId,creatorId:$creatorId,createdAt:$createdAt";
  }
}
