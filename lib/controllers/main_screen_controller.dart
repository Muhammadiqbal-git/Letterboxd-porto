import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/home_controller.dart';
import 'package:letterboxd_porto_3/controllers/profile_controller.dart';

class MainScreenController extends GetxController{
  Rx<int> index = 0.obs;
  final HomeController _homeController = Get.find<HomeController>();
  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  void onInit() {
    super.onInit();
  }
  void changeIndex(int i){
    index.value = i;
    if (index.value == 0) {
      // _homeController.getData();
    }
    else if(index.value == 3){
      _profileController.readProfile();
    }
    else{
      print("do nothing");
    }
  }
}