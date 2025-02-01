import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:insta_clone/user_feature/core/failure.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';
import 'package:insta_clone/user_feature/presentation/controller/user_controller/app_controller/main_page_controller.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';

import '../../../../domain/entity/user_entity.dart';

class AddPostController extends GetxController {
  TextEditingController descriptionController = TextEditingController();
  final createPostUsecase = Get.find<CreatePostUseCase>();
  final updatePostUseCase = Get.find<UpdatePostUsecase>();
  final mainPageController = Get.find<MainPageController>();
  PostEntity? thePostEntity;
  final RxList<AssetPathEntity> _albums = <AssetPathEntity>[].obs;
  final RxString _addOrUpdate = "Post".obs;

  String get addOrUpdate => _addOrUpdate.value;

  set addOrUpdate(String addOrUpdate) {
    _addOrUpdate.value = addOrUpdate;
  }

  RxInt index = 0.obs;
  RxString albumName = "Recent".obs;
  RxString postImagePath = "".obs;
  RxBool isLoading = false.obs;
  final RxList<AssetEntity> _assets = <AssetEntity>[].obs;

  List<AssetPathEntity> get albums => _albums;

  List<AssetEntity> get assets => _assets;

  set assets(List<AssetEntity> assets) {
    _assets.value = assets;
  }

  LoadAlbumsUsecase loadAlbumsUsecase = Get.find<LoadAlbumsUsecase>();
  LoadAssetsUsecase loadAssetsUsecase = Get.find<LoadAssetsUsecase>();
  AddImageToFireStorageUsecase addImageToFireStorageUsecase =
      Get.find<AddImageToFireStorageUsecase>();

  Future<List<AssetPathEntity>> loadAlbums() async {
    _albums.value = await loadAlbumsUsecase.call();
    return _albums;
  }

  Future<List<AssetEntity>> loadAssets() async {
    _assets.clear();
    final albums = await loadAlbums();
    final selectedAlbum =
        albums.where((element) => element.name == albumName.value).toList();
    _assets.value = await loadAssetsUsecase.call(selectedAlbum[0]);
    return _assets;
  }

  Future addPostImageToStorage() async {
    try {
      return await addImageToFireStorageUsecase.call(
          File(postImagePath.value), true);
    } on Failure catch (e) {
      Get.snackbar("error", e.errorMessage.toString());
      isLoading.value = false;
    }
  }

  Future createPost() async {
    isLoading.value = true;
    final currentUser = mainPageController.currentUser;
    final postId = const Uuid().v4();
    try{
      final imageUrl = await addPostImageToStorage();
    PostEntity postEntity = PostEntity(
        name: currentUser!.name,
        userName: currentUser.userName,
        createdAt: Timestamp.now(),
        creatorId: currentUser.uid,
        profileImage: currentUser.profileUrl,
        postImageUrl: imageUrl,
        postId: postId,
        description: descriptionController.text.trim());
    final updatedUser=UserEntity(
        uid: mainPageController.currentUser!.uid,
        postNumber: mainPageController.currentUser!.postNumber!+1
    );
    await createPostUsecase.call(postEntity,updatedUser);
    isLoading.value = false;
    descriptionController.clear();
    Get.snackbar("message", "the post has been successfully crated");
    Get.back();
    mainPageController.currentIndex=0;}
        on Failure catch(e){
      Get.snackbar("error", e.errorMessage!);
      isLoading.value=false;
        }

  }

  Future updatePost() async {
    try{
      isLoading.value=true;
      if(addOrUpdate=="update post"){
        final imageUrl = await addPostImageToStorage();
        final postEntity=PostEntity(
        description: descriptionController.text,
       postId: thePostEntity!.postId,
        postImageUrl: imageUrl
      );
        await updatePostUseCase.call(postEntity);
      }else if(addOrUpdate=="Update Post"){
        final postEntity=PostEntity(
            description: descriptionController.text,
            postId: thePostEntity!.postId,
        );
        await updatePostUseCase.call(postEntity);
      }


      Get.back();
      isLoading.value=false;

    }
    on Failure catch (e){
      Get.snackbar("error", e.errorMessage!);
      isLoading.value=false;
    }

  }

  @override
  void onInit() async {
    super.onInit();
    loadAlbums();
    loadAssets();
  }
}
