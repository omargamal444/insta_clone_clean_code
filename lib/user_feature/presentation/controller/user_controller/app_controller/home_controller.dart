import 'package:get/get.dart';
import 'package:insta_clone/user_feature/core/data_connection_checker.dart';
import 'package:insta_clone/user_feature/data/data_source/remote_data_source/remote_data_source_impl.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/domain/entity/user_entity.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';

import '../../../../core/failure.dart';

class HomeController extends GetxController {
   RxList<bool> showDeleteWidget=<bool>[].obs;
  GetPostUsecase getPostUsecase=Get.find<GetPostUsecase>();
  final Connection connectionChecker=Get.find<Connection>();
  LikePostUsecase likePostUsecase=Get.find<LikePostUsecase>();
  final currentUser=Get.find<RemoteDataSourceImpl>();
  DeletePostUseCase deletePostUseCase=Get.find<DeletePostUseCase>();
  Stream<List<PostEntity>>getPosts(UserEntity currentUser,String useLocation){
    try{
      return (getPostUsecase.call(currentUser,useLocation));
    }
    on Failure catch (e){
      Get.snackbar("error", e.errorMessage!);
      throw "";
    }
  }
  Future<bool> likePost(PostEntity postEntity)async{
return await likePostUsecase.call(postEntity);
 }
 Future deletePost({required PostEntity postEntity})async{
    try{
      return await deletePostUseCase.call(postEntity);
    }
   on Failure catch (e){
   Get.snackbar("error", e.errorMessage!);
   throw "";
   }
 }

}
