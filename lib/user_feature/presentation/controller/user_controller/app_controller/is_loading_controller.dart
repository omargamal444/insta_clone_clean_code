import 'package:get/get.dart';

class IsLoadingController extends GetxController{
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool isLoading){_isLoading.value=isLoading;}
}