
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/discover_film_controller.dart';
import 'package:letterboxd_porto_3/controllers/discover_people_controller.dart';
import 'package:letterboxd_porto_3/controllers/home_controller.dart';
import 'package:letterboxd_porto_3/controllers/main_screen_controller.dart';
import 'package:letterboxd_porto_3/controllers/movie_detail_controller.dart';
import 'package:letterboxd_porto_3/controllers/profile_controller.dart';
import 'package:letterboxd_porto_3/controllers/review_controller.dart';
import 'login_controller.dart';
import 'register_controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}

class MainScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MainScreenController>(() => MainScreenController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DiscoverFilmController>(() => DiscoverFilmController());
    Get.lazyPut<DiscoverPeopleController>(() => DiscoverPeopleController());
    Get.lazyPut<ProfileController>(() => ProfileController());


  }
}

class MovieDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MovieController>(() => MovieController(),);
    Get.lazyPut<ReviewController>(() => ReviewController(),);
  }
}
class ReviewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ReviewController>(() => ReviewController(),);
  }
}
