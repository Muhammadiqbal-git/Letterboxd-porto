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
  Rx<RecentMovieState> recentState = Rx(RecentMovieState.loading);
  Rx<RecentReviewState> reviewState = Rx(RecentReviewState.loading);

  @override
  void onInit() {
    readProfile();
    super.onInit();
  }

  // profile
  readProfile({bool update = false}) async {
    recentState.value = RecentMovieState.loading;
    String uId = _service.userId ?? "";
    CollectionReference filmReviewRef = _db.collection("/film_review");
    DocumentReference<Map<String, dynamic>> profileRef =
        _db.collection("/profile").doc(uId);
    QuerySnapshot<Map<String, dynamic>> recent = await profileRef
        .collection("recent")
        .orderBy("date", descending: true)
        .get();
    ReviewModel recentReview = await getRecentReview(uId: uId);
    await profileRef.get().then((value) async {
      ProfileModel data =
          ProfileModel.fromFirestore(value, recent, recentReview.reviewData, SnapshotOptions());
      user.value = data;
      userEmail.value = _service.userEmail;
      if (recent.docs.isEmpty) {
        recentState.value = RecentMovieState.error;
      } else {
        recentState.value = RecentMovieState.done;
      }
      if (data.favorite.isNotEmpty) {
        favoriteLength.value =
            data.favorite.length >= 3 ? 3 : data.favorite.length;
      }
      if (update) {
        WriteBatch batch = _db.batch();
        for (var snapshot in recent.docs) {
          batch.update(
              filmReviewRef.doc(snapshot.id).collection("review").doc(uId),
              {"u_name": data.uName, "photo_path": data.photo_path});
        }
        await batch.commit().then((value) => print("success"));
      }
    });
  }

  Future<ReviewModel> getRecentReview(
      { required String uId}) async {
    QuerySnapshot<Map<String, dynamic>> reviewData = await _db
        .collectionGroup("review")
        .where("u_id", whereIn: [uId, "dv03efAW3Wd0oMtmRgZujvlBOD33"])
        .orderBy("date", descending: true)
        .get();
    return ReviewModel.fromFirestore(reviewData, null);
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

enum RecentMovieState { loading, done, error }

enum RecentReviewState { loading, done, error }
