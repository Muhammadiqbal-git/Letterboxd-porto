import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/firebase_auth_services.dart';
import 'package:letterboxd_porto_3/controllers/home_controller.dart';
import 'package:letterboxd_porto_3/controllers/tmdb_services.dart';
import 'package:letterboxd_porto_3/models/movie_cast_model.dart';
import 'package:letterboxd_porto_3/models/movie_detail_model.dart';

class MovieController extends GetxController {
  Rx<MovieState> state = Rx(MovieState.loading);
  Rx<MovieDetail?> detailData = Rx(null);
  Rx<List<Cast>> castData = Rx([]);

  Rx<String> director = "".obs;

  MovieCast? _cast;
  TMDBServices services = TMDBServices();

  @override
  void onInit() {
    getDetail(Get.arguments['id']);
    super.onInit();
  }

  getDetail(int id) async {
    state.value = MovieState.loading;
    detailData.value = await services.getMovieDetail(id: id);
    _cast = await services.getMovieCast(id: id);

    if (detailData.value != null && _cast != null) {
      _cast!.cast.sort(
        (a, b) {
          if (a.popularity < b.popularity) {
            return 1;
          } else {
            return -1;
          }
        },
      );
      castData.value = _cast!.cast;
      director.value = _cast!.crew
          .firstWhere((element) => element.job.toLowerCase() == "director")
          .name;
      state.value = MovieState.done;
    } else {
      state.value = MovieState.error;
    }
  }


}

enum MovieState { loading, done, error }
