import 'package:get/get.dart';
import '../models/movie_list_model.dart';
import 'tmdb_services.dart';

class HomeController extends GetxController {
  Rx<MovieData?> data = Rx<MovieData?>(null);
  Rx<bool> loading = false.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    print("getdata");
    loading.value = true;
    data.value = await TMDBServices().getMovieOfTheMonth();
    print(data.value);
    loading.value = false;
  }
}
