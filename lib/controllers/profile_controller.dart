import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letterboxd_porto_3/controllers/firebase_auth_services.dart';
import 'package:letterboxd_porto_3/models/profile_model.dart';

import '../models/review_snapshot_model.dart';

class ProfileController extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuthService _service = FirebaseAuthService();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  Rx<ProfileModel?> user = Rx<ProfileModel?>(null);
  Rx<String?> userEmail = "".obs;
  Rx<int> favoriteLength = 1.obs;

  Rx<ProfileState> state = Rx(ProfileState.loading);
  Rx<RecentMovieState> recentState = Rx(RecentMovieState.loading);
  Rx<RecentReviewState> reviewState = Rx(RecentReviewState.loading);

  @override
  void onInit() {
    readProfile();
    super.onInit();
  }

  // profile
  readProfile({bool update = false}) async {
    print("high read profile ops run");
    state.value = ProfileState.loading;
    recentState.value = RecentMovieState.loading;
    String uId = _service.userId ?? "";
    CollectionReference filmReviewRef = _db.collection("/film_review");
    DocumentReference<Map<String, dynamic>> profileRef =
        _db.collection("/profile").doc(uId);
    QuerySnapshot<Map<String, dynamic>> recentWatch = await profileRef
        .collection("recent")
        .orderBy("date", descending: true)
        .get();
    QuerySnapshot<Map<String, dynamic>> recentReview =
        await getRecentReview(uId: uId);
    await profileRef.get().then((value) async {
      ProfileModel data = ProfileModel.fromFirestore(
          value,
          recentWatch,
          ReviewModel.fromFirestore(recentReview, null).reviewData,
          SnapshotOptions());
      user.value = data;
      userEmail.value = _service.userEmail;
      state.value = ProfileState.done;
      syncProfileData(data, profileRef, filmReviewRef);
      if (recentWatch.docs.isEmpty) {
        recentState.value = RecentMovieState.error;
      } else {
        recentState.value = RecentMovieState.done;
      }
      if (data.favorite.isNotEmpty) {
        favoriteLength.value =
            data.favorite.length >= 3 ? 3 : data.favorite.length;
      }
    });
  }

  syncProfileData(ProfileModel data, DocumentReference profileRef,
      CollectionReference filmReviewRef) async {
    String uId = _service.userId ?? "";
    WriteBatch batch = _db.batch();
    bool check = false;
    for (var element in data.recentRev!) {
      if (data.photo_path != element.photoPath) {
        check = true;
      }
    }
    if (check) {
      for (var filmRevId in data.reviewRef) {
        batch.update(
            filmReviewRef.doc("$filmRevId").collection("review").doc(uId),
            {"u_name": data.uName, "photo_path": data.photo_path});
      }
    }
    for (var filmRev in data.recentRev!) {
      List listOfId = [];
      if (!data.reviewRef.contains(filmRev.filmInfoModel.filmId)) {
        listOfId.add(filmRev.filmInfoModel.filmId);
      }
      batch.update(profileRef, {"review_ref": FieldValue.arrayUnion(listOfId)});
    }
    await batch.commit().then((value) => print("success"));
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRecentReview(
      {required String uId}) async {
    QuerySnapshot<Map<String, dynamic>> reviewData = await _db
        .collectionGroup("review")
        .where("u_id", whereIn: [uId, "dv03efAW3Wd0oMtmRgZujvlBOD33"])
        .orderBy("date", descending: true)
        .get();

    return reviewData;
  }

  imgPicker() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    String uId = _service.userId ?? "";
    if (image != null) {
      SettableMetadata imgMetadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': image.path});
      Reference storageRef = _storage.ref("profile_images/").child("$uId.jpg");
      await storageRef.putFile(File(image.path), imgMetadata);
      await storageRef.getDownloadURL().then((value) {
        _db.collection("/profile").doc(uId).update({"photo_path": value});
      });
      await readProfile(update: true);
    }
  }
}

enum ProfileState { loading, done, error }

enum RecentMovieState { loading, done, error }

enum RecentReviewState { loading, done, error }
