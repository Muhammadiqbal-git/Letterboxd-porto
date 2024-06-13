import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/models/review_snapshot_model.dart';
import '../models/movie_list_model.dart';
import 'profile_controller.dart';
import 'tmdb_services.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TMDBServices _tmdbServices = TMDBServices();
  final ProfileController _profileController = Get.find<ProfileController>();
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
    print("getData");
    DateTime now = DateTime.now();
    loading.value = true;
    data.value = await _tmdbServices.getMovieOfTheMonth();
    await Future.delayed(Duration(milliseconds: 1000));
    ratedData.value = await _tmdbServices.getMovieOfTheMonth(
        date: DateTime(now.year, now.month - 3), sortBy: "vote_average.desc");
    profileFunction();
    if (data.value != null) {
      loading.value = false;
    }
  }

  profileFunction() async {
    if (_profileController.cacheUser.value != null) {
      reviewData.value =
          await getHomeReview(_profileController.cacheUser.value!.following);
    } else {
      reviewData.value =
          await getHomeReview(_profileController.displayUser.value!.following);
    }
  }

  Future<ReviewModel?> getHomeReview(List listId) async {
    if (listId.isEmpty) {
      return null;
    }
    QuerySnapshot<Map<String, dynamic>> reviewData = await _db
        .collectionGroup("review")
        .where("u_id", whereIn: listId)
        .orderBy("date", descending: true)
        .get();
    return ReviewModel.fromFirestore(reviewData, null);
  }
}
