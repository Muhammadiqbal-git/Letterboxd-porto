import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/review_controller.dart';
import 'package:letterboxd_porto_3/models/review_snapshot_model.dart';
import '../models/movie_list_model.dart';
import 'tmdb_services.dart';

class HomeController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  TMDBServices _tmdbServices = TMDBServices();
  Rx<MovieData?> data = Rx<MovieData?>(null);
  Rx<MovieData?> ratedData = Rx(null);
  Rx<bool> loading = false.obs;
  Rx<ReviewModel?> reviewData = Rx(null);

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    DateTime now = DateTime.now();
    loading.value = true;
    data.value = await _tmdbServices.getMovieOfTheMonth();
    ratedData.value = await _tmdbServices.getMovieOfTheMonth(
      date: DateTime(now.year, now.month-3),
      sortBy: "vote");
    reviewData.value = await getHomeReview();
    print(data.value);
    if (data.value != null) {
      loading.value = false;
    }
  }

  Future<ReviewModel> getHomeReview() async {
    QuerySnapshot<Map<String, dynamic>> reviewData = await _db
        .collectionGroup("review")
        .orderBy("date", descending: true)
        .get();
    return ReviewModel.fromFirestore(reviewData, null);
  }
}
