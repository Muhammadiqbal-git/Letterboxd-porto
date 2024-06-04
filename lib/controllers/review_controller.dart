import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:letterboxd_porto_3/controllers/movie_detail_controller.dart';
import 'package:letterboxd_porto_3/helpers/dimension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letterboxd_porto_3/models/profile_model.dart';
import 'tmdb_services.dart';
import 'firebase_auth_services.dart';

class ReviewController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  TMDBServices services = TMDBServices();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<TextEditingController> reviewText = TextEditingController().obs;
  MovieController movieController = Get.find<MovieController>();

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

  addReview({
    required int filmId,
    required String review,
    required DateTime date,
    required int rate,
    required String posterPath,
    bool favorite = false,
  }) async {
    String userId = FirebaseAuthService().userId!;
    DocumentReference filmRef = db.collection("/film_info").doc("$filmId");
    DocumentReference reviewRef = db
        .collection("/film_review")
        .doc("$filmId")
        .collection("review")
        .doc(userId);
    DocumentReference profileWatchedRef = db
        .collection("/profile")
        .doc(userId)
        .collection("recent")
        .doc("$filmId");
    DocumentSnapshot<Map<String, dynamic>> profileSnapshot =
        await db.collection("/profile").doc(FirebaseAuthService().userId).get();
    ProfileModel profileModel =
        ProfileModel.fromFirestore(profileSnapshot, null, SnapshotOptions());
    WriteBatch batch = db.batch();
    batch.set(
        filmRef,
        {
          "poster_path": movieController.detailData.value?.posterPath ?? "",
          "backdrop_path": movieController.detailData.value?.backdropPath,
          "title": movieController.detailData.value?.title,
          "year_release": movieController.detailData.value?.releaseDate,
        },
        SetOptions(merge: true));
    batch.set(
        reviewRef,
        {
          "date": date,
          "review": review,
          "rate": rate,
          "u_id": profileModel.uId,
          "u_name": profileModel.uName,
          "photo_path": profileModel.photo_path
        },
        SetOptions(merge: true));
    batch.set(
        profileWatchedRef,
        {
          "date": date,
          "review": review,
          "rate": rate,
        },
        SetOptions(merge: true));

    if (favorite) {
      DocumentReference favoriteRef =
          db.collection("/profile").doc(FirebaseAuthService().userId);
      batch.set(
          favoriteRef,
          {
            "favorite": {"$filmId": posterPath}
          },
          SetOptions(merge: true));
    }

    try {
      await batch.commit().then((value) => print("sukes"));
    } catch (e) {
      print("error while performing batch write to firestore: \n$e");
    }
  }

  getRecentReview({required int filmId}) async {
    QuerySnapshot<Map<String, dynamic>> reviewData = await db
        .collection("/film_review")
        .doc("$filmId")
        .collection("review")
        .orderBy("date", descending: true)
        .get();
    DocumentSnapshot<Map<String, dynamic>> filmDetail =
        await db.collection("/film_info").doc("$filmId").get();
    reviewData.do

  // getAllReview({required int filmId}) async {
  //   DocumentSnapshot filmData =
  //   QuerySnapshot reviewData = await db
  //       .collection("film_review")
  //       .doc("$filmId")
  //       .collection("review")
  //       .orderBy("date", descending: true)
  //       .get();
  //   // CollectionReference recentWatch =
  //   //     db.collection("profile").doc("${FirebaseAuthService().userId}").collection("recent");
  //   try {
  //     // var data = await recentWatch.orderBy("date", descending: false).get();
  //     // for (var d in data.docs) {
  //     //   print(d.id);
  //     //   print(d.data());
  //     // }
  //     var data = await allReviewRef.get();
  //     print(data.data());
  //   } catch (e) {}
  // }
}
