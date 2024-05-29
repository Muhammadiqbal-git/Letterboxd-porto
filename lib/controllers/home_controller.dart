import 'package:get/get.dart';
import '../models/movie_list_model.dart';
import 'tmdb_services.dart';

class HomeController extends GetxController {
  Rx<MovieData?> data = Rx<MovieData?>(null);
  static final Rx<bool> loading = false.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    print("getdata");
    loading.value = true;
    data.value = await TMDBServices().getMovieOfTheMonth();
    loading.value = false;
  }
}
