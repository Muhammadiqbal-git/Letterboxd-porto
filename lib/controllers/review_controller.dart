import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/movie_detail_controller.dart';
import 'package:letterboxd_porto_3/helpers/dimension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letterboxd_porto_3/models/profile_model.dart';
import 'package:letterboxd_porto_3/models/review_snapshot_model.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_alert_dialog.dart';
import 'firebase_auth_services.dart';

class ReviewController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  MovieController movieController = Get.find<MovieController>();
  ProfileModel? _profileModel;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<int> rate = 1.obs;
  Rx<bool> fav = false.obs;
  Rx<TextEditingController> reviewText = TextEditingController().obs;

  @override
  onInit() async {
    DocumentSnapshot<Map<String, dynamic>> profileSnapshot = await _db
        .collection("/profile")
        .doc(FirebaseAuthService().userId)
        .get();
    _profileModel = ProfileModel.fromFirestore(
        profileSnapshot, null, null, SnapshotOptions());
    super.onInit();
  }

  Future<void> datePicker(BuildContext context) async {
    DateTime now = selectedDate.value;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2018, 8),
      lastDate: now,
      builder: (context, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400 + getHeight(context, 10),
            width: 250 + getWidth(context, 15),
            child: child,
          )
        ],
      ),
    );
    if (picked != null && picked != now) {
      selectedDate.value = picked;
    }
  }

  addReview() async {
    if (_profileModel == null) {
      print("profile model null");
      return;
    }
    String userId = FirebaseAuthService().userId!;
    int filmId = movieController.detailData.value!.id;
    DocumentReference reviewRef = _db
        .collection("/film_review")
        .doc("$filmId")
        .collection("review")
        .doc(userId);
    DocumentReference profileWatchedRef = _db
        .collection("/profile")
        .doc(userId)
        .collection("recent")
        .doc("$filmId");

    WriteBatch batch = _db.batch();
    batch.set(
        profileWatchedRef,
        {
          "date": selectedDate.value,
          "review": reviewText.value.text,
          "rate": rate.value,
          "poster_path": movieController.detailData.value!.posterPath
        },
        SetOptions(merge: true));
    if (reviewText.value.text.isNotEmpty) {
      batch.set(
          reviewRef,
          {
            "u_id": _profileModel!.uId,
            "u_name": _profileModel!.uName,
            "photo_path": _profileModel!.photo_path,
            "date": selectedDate.value,
            "review": reviewText.value.text,
            "rate": rate.value,
            "film_info": {
              "poster_path": movieController.detailData.value?.posterPath ?? "",
              "backdrop_path": movieController.detailData.value?.backdropPath,
              "title": movieController.detailData.value?.title,
              "year_release": movieController.detailData.value?.releaseDate,
            }
          },
          SetOptions(merge: true));
    }
    if (fav.value) {
      DocumentReference favoriteRef =
          _db.collection("/profile").doc(FirebaseAuthService().userId);
      batch.set(
          favoriteRef,
          {
            "favorite": {
              "$filmId": movieController.detailData.value!.posterPath
            }
          },
          SetOptions(merge: true));
    }
    try {
      await batch.commit().then((value) => Get.dialog(
            const CustomAlertDialog(
                textAlign: TextAlign.center,
                text: "Rating atau review berhasil ditambahkan"),
          ).then((value) async {
            movieController.reviewData.value =
                await getRecentReview(filmId: filmId);
            Get.back();
          }));
    } catch (e) {
      print("error while performing batch write to firestore: \n$e");
    }
  }

  Future<ReviewModel> getRecentReview({required int filmId}) async {
    QuerySnapshot<Map<String, dynamic>> reviewData = await _db
        .collection("/film_review")
        .doc("$filmId")
        .collection("review")
        .orderBy("date", descending: true)
        .get();
    return ReviewModel.fromFirestore(reviewData, null);
  }
}
