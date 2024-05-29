import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/home_controller.dart';

class MainScreenController extends GetxController{
  Rx<int> index = 0.obs;
  HomeController _homeController = Get.find<HomeController>();
  @override
  void onInit() {
    // _homeController.getData();
    super.onInit();
  }
  void changeIndex(int i){
    index.value = i;
    if (index.value == 0) {
      _homeController.getData();
      print(HomeController.loading);
    }
    else{
      print("do nothing");
    }
  }
}