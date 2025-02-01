import 'package:cloud_firestore/cloud_firestore.dart';

class PostEntity{
  String?postImageUrl;
  String?profileImage;
  String?userName;
  int?likeNumber;
  String?name;
  Timestamp?createdAt;
  String?postId;
  String?creatorId;
  List? likes;
  String?description;
  int?commentNumber;

  PostEntity({
      this.postImageUrl,
      this.profileImage,
      this.userName,
      this.likeNumber,
      this.name,
      this.createdAt,
      this.postId,
      this.creatorId,
      this.likes,
      this.description,
      this.commentNumber});
}