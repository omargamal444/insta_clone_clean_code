import 'package:data_connection_checker_tv/data_connection_checker.dart';

class Connection{
  Future<bool> isConnected=DataConnectionChecker().hasConnection;
}