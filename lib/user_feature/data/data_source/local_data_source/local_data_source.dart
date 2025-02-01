import 'package:photo_manager/photo_manager.dart';

abstract class LocalDataSource{
  Future<List<AssetPathEntity>>loadAlbums();
  Future<List<AssetEntity>>loadAssets(AssetPathEntity album);

}