import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/home_controller.dart';
import 'package:letterboxd_porto_3/controllers/profile_controller.dart';

class MainScreenController extends GetxController{
  Rx<int> index = 0.obs;
  final ProfileController _profileController = Get.find<ProfileController>();
  final HomeController _homeController = Get.find<HomeController>();


  void changeIndex(int i){
    index.value = i;
    if (index.value == 0) {
      _homeController.profileFunction();
    }
    else if(index.value == 3){
      _profileController.readProfile();
    }
    else{
    }
  }
}