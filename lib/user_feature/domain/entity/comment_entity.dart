import 'package:cloud_firestore/cloud_firestore.dart';

class CommentEntity{
  String? commentatorProfileImageUrl;
  String?commentDescription;
  String? commentatorName;
  Timestamp?createdAt;
  List? likes;
  int? likeNumber;
  String? postId;
  String?commentId;
  String?commentatorUid;
  String?creatorId;
  String?isMainComment;
  String?mainCommentId;
  List?subComments;

  CommentEntity({
    this.mainCommentId,
    this.commentatorProfileImageUrl,
    this.commentatorName,
    this.createdAt,
    this.commentDescription,
    this.likes,
    this.likeNumber,
    this.postId,
    this.commentId,
    this.commentatorUid,
    this.creatorId,
    this.isMainComment,
    this.subComments

  });
}