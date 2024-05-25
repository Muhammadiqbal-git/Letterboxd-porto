import 'package:get/get.dart';

class MainScreenController extends GetxController{
  Rx<int> index = 0.obs;

  void changeIndex(int i){
    index.value = i;
  }
}