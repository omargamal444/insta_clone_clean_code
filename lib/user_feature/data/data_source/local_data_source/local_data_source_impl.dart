import 'package:insta_clone/user_feature/data/data_source/local_data_source/local_data_source.dart';
import 'package:photo_manager/photo_manager.dart';
class LocalDataSourceImpl implements LocalDataSource{
  @override
  Future<List<AssetPathEntity>>loadAlbums()async{
    List<AssetPathEntity>?albumList;
    final permission=await PhotoManager.requestPermissionExtend();
    if(permission.isAuth)
    {
      albumList=await PhotoManager.getAssetPathList();
    }
    else{
      PhotoManager.openSetting();

    }
    return albumList!;
  }
  @override
 Future <List<AssetEntity>> loadAssets(AssetPathEntity album)async{
    List<AssetEntity>assetList;
   assetList= await album.getAssetListRange(start:0, end:await album.assetCountAsync);
   return assetList;
 }


}