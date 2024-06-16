import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/review_controller.dart';
import 'package:letterboxd_porto_3/controllers/tmdb_services.dart';
import 'package:letterboxd_porto_3/models/movie_cast_model.dart';
import 'package:letterboxd_porto_3/models/movie_detail_model.dart';
import 'package:letterboxd_porto_3/models/review_snapshot_model.dart';

class MovieController extends GetxController {
  final TMDBServices _services = TMDBServices();
  MovieCast? _cast;
  Rx<MovieState> state = Rx(MovieState.loading);
  Rx<MovieDetail?> detailData = Rx(null);
  Rx<ReviewModel?> reviewData = Rx(null);
  RxList<Cast> castData = <Cast>[].obs;
  Rx<String> director = "".obs;

  @override
  void onInit() {
    getDetail(Get.arguments['id']);
    super.onInit();
  }

  getDetail(int id) async {
    state.value = MovieState.loading;
    detailData.value = await _services.getMovieDetail(id: id);
    print("sad");
    print(detailData.value?.title);
    reviewData.value = await ReviewController().getRecentReview(filmId: id);
    print("aaaa");

    // print(reviewData.value!.reviewData[0].photoPath);
    _cast = await _services.getMovieCast(id: id);
    print(_cast?.cast);
    print("aaaass");

    if (detailData.value != null && _cast != null) {
      print("awww");
      _cast!.cast.sort(
        (a, b) {
          if (a.popularity < b.popularity) {
            return 1;
          } else {
            return -1;
          }
        },
      );
      castData.assignAll(_cast!.cast);
      director.value = _cast!.crew
              .firstWhereOrNull(
                  (element) => element.job.toLowerCase() == "director")
              ?.name ??
          "Someone (no data)";
      state.value = MovieState.done;
    } else {
      state.value = MovieState.error;
    }
  }
}

enum MovieState { loading, done, error }
