import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/core/failure.dart';
import 'package:insta_clone/user_feature/domain/entity/comment_entity.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/is_loading_controller.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/main_page_controller.dart';
import 'package:uuid/uuid.dart';

class CommentController extends GetxController {
  LikeCommentUseCase likeCommentUseCase = Get.find<LikeCommentUseCase>();
  CreateCommentUsecase createCommentUsecase = Get.find<CreateCommentUsecase>();
  final getSubCommentsUseCase=Get.find<GetSubCommentsUsecase>();
  GetCommentsUsecase getCommentsUseCase = Get.find<GetCommentsUsecase>();
  final updatePostUseCase=Get.find<UpdatePostUsecase>();
  CommentEntity theMainCommentEntity = CommentEntity();
  final deleteCommentUseCase = Get.find<DeleteCommentUseCase>();
  final updateCommentUseCase = Get.find<UpdateCommentUsecase>();
  final isLoadingController = Get.find<IsLoadingController>();
  final mainController = Get.find<MainPageController>();
  final RxString _updateOrCreateOrReply = "create".obs;

  String get updateOrCreateOrReply => _updateOrCreateOrReply.value;

  set updateOrCreateOrReply(String updateOrCreate) {
    _updateOrCreateOrReply.value = updateOrCreate;
  }

  PostEntity postEntity = PostEntity();
  UserEntity currentUser = UserEntity();
  CommentEntity commentEntity = CommentEntity();
  CommentEntity subCommentEntity = CommentEntity();
  TextEditingController commentController = TextEditingController();

  Future createComment(String isMainComment) async {
    isLoadingController.isLoading = true;
    final commentId = const Uuid().v4();
     mainController.getCurrentUser().listen((event) {currentUser=event;});
    final commentEntity = CommentEntity(
        commentDescription: commentController.text.trim(),
        postId: postEntity.postId,
        commentatorName: currentUser.name,
        commentatorProfileImageUrl: currentUser.profileUrl,
        commentatorUid: currentUser.uid,
        commentId: commentId,
        createdAt: Timestamp.now(),
        creatorId: currentUser.uid,
        isMainComment: isMainComment,
        mainCommentId: theMainCommentEntity.commentId);
    try {
      await createCommentUsecase.call(commentEntity);
      if (commentEntity.isMainComment == "replyComment") {
        theMainCommentEntity.subComments!.add(commentEntity.commentId);
        final mainCommentEntity = CommentEntity(
            subComments: theMainCommentEntity.subComments,
            commentId: theMainCommentEntity.commentId);
        await updateCommentUseCase.call(mainCommentEntity);
      }
      isLoadingController.isLoading = false;
      commentController.clear();
    } on Failure catch (e) {
      Get.snackbar("error", e.errorMessage!);
      isLoadingController.isLoading = false;
    }
  }

  Stream<List<CommentEntity>> getComments(PostEntity postEntity) {
    try {
      return getCommentsUseCase.call(postEntity);
    } on Failure catch (e) {
      Get.snackbar("error", e.errorMessage!);
      throw "";
    }
  }

  Future liKeComment() async {
    try {
      await likeCommentUseCase.call(commentEntity, postEntity);
    } on Failure catch (e) {
      Get.snackbar("error", e.errorMessage!);
    }
  }

  Future<void> deleteComment() async {
    try {
      await deleteCommentUseCase.call(commentEntity);
    } on Failure catch (e) {
      Get.snackbar("error", e.errorMessage!);
    }
  }

  Future updateComment() async {
    isLoadingController.isLoading = true;
    final newCommentEntity = CommentEntity(
      commentDescription: commentController.text.trim(),
      commentId: commentEntity.commentId,
    );
    try {
      await updateCommentUseCase.call(newCommentEntity);
      isLoadingController.isLoading = false;
    } on Failure catch (e) {
      Get.snackbar("error", e.errorMessage!);
      isLoadingController.isLoading = false;
    }
  }

  Stream<List<CommentEntity>> getSubComments(CommentEntity mainCommentEntity) {
    try{
      return getSubCommentsUseCase.call(mainCommentEntity);
    }
    on Failure catch(e){
      Get.snackbar("error", e.errorMessage!);
      throw Failure(errorMessage: "error");
    }
  }

  @override
  void onInit() {
    super.onInit();
  mainController.getCurrentUser().listen((event) { currentUser=event;});
  }
}
