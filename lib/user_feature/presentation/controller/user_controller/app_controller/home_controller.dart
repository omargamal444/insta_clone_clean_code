import 'package:get/get.dart';
import 'package:insta_clone/user_feature/core/data_connection_checker.dart';
import 'package:insta_clone/user_feature/data/data_source/remote_data_source/remote_data_source_impl.dart';
import 'package:insta_clone/user_feature/domain/entity/post_entity.dart';
import 'package:insta_clone/user_feature/domain/use_case/user_usecase.dart';

class HomeController extends GetxController {
  final RxBool _isLike =false.obs;
  GetPostUsecase getPostUsecase=Get.find<GetPostUsecase>();
  final Connection connectionChecker=Get.find<Connection>();
  LikePostUsecase likePostUsecase=Get.find<LikePostUsecase>();
  final currentUser=Get.find<RemoteDataSourceImpl>();
  Stream<List<PostEntity>>getPosts(){
   return (getPostUsecase.call());
  }
  Future<bool> likePost(PostEntity postEntity)async{
 return _isLike.value= await likePostUsecase.call(postEntity);
 }
}
