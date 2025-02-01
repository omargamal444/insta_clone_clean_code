import 'package:insta_clone/const.dart';
import 'package:insta_clone/user_feature/domain/entity/comment_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel(
      {super.commentatorName,
      super.commentatorProfileImageUrl,
      super.commentDescription,
      super.commentId,
      super.createdAt,
      super.likeNumber,
      super.likes,
      super.postId,
      super.commentatorUid,
      super.creatorId,
      super.isMainComment,
      super.subComments,
      super.mainCommentId
      });

  factory CommentModel.fromDocSnapShot(Map<String, dynamic> data) {
    return CommentModel(
      postId: data[FirebaseConst.postId],
      likeNumber: data[FirebaseConst.likeNumber],
      createdAt: data[FirebaseConst.createdAt],
      likes: data[FirebaseConst.likes],
      commentatorName: data[FirebaseConst.commentatorName],
      commentatorProfileImageUrl:
          data[FirebaseConst.commentatorProfileImageUrl],
      commentDescription: data[FirebaseConst.commentDescription],
      commentId: data[FirebaseConst.commentId],
      commentatorUid: data[FirebaseConst.commentatorUid],
      creatorId: data[FirebaseConst.creatorId],
      isMainComment: data[FirebaseConst.isMainComment],
      subComments:data[FirebaseConst.subComments],
      mainCommentId:data[FirebaseConst.mainCommentId]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      FirebaseConst.postId: postId,
      FirebaseConst.likeNumber: likeNumber,
      FirebaseConst.createdAt: createdAt,
      FirebaseConst.likes: likes,
      FirebaseConst.commentatorName: commentatorName,
      FirebaseConst.commentatorProfileImageUrl: commentatorProfileImageUrl,
      FirebaseConst.commentDescription: commentDescription,
      FirebaseConst.commentId: commentId,
      FirebaseConst.commentatorUid: commentatorUid,
      FirebaseConst.creatorId:creatorId,
      FirebaseConst.isMainComment:isMainComment,
      FirebaseConst.subComments:subComments,
      FirebaseConst.mainCommentId:mainCommentId
    };
  }
}
