import 'dart:async';
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
  final String _uId = FirebaseAuthService().userId ?? "";

  Rxn<ProfileModel> displayUser = Rxn<ProfileModel>();
  Rxn<NotificationModel> notif = Rxn<NotificationModel>();
  Rxn<ProfileModel> cacheUser = Rxn<ProfileModel>();
  Rx<String?> userEmail = "".obs;
  Rx<int> favoriteLength = 0.obs;
  Rx<bool> followed = false.obs;
  Rx<ProfileState> state = Rx(ProfileState.loading);
  Rx<RecentMovieState> recentState = Rx(RecentMovieState.loading);
  Rx<RecentReviewState> reviewState = Rx(RecentReviewState.loading);
  late Query<Map<String, dynamic>> collection;
  late StreamSubscription notifListener;
  ProfileModel? get user{
    if (cacheUser.value != null) {
      return cacheUser.value;
    }else{
      return displayUser.value;
    }
  }

  @override
  void onInit() {
    collection = _db
        .collection("/profile")
        .doc(_uId)
        .collection("notification")
        .orderBy("date", descending: true);
    notifListener = collection.snapshots().listen((event) {
      notif.value = NotificationModel.fromFirestore(event);
    });
    readProfile();
    super.onInit();
  }

  @override
  void onClose() {
    notifListener.cancel();
  }

  readNotif(String docId) async {
    DocumentReference docRef = _db
        .collection("/profile")
        .doc(_uId)
        .collection("notification")
        .doc(docId);
    await docRef.update({"read": true});
  }

  addNotif(String otherId) async {
    if (displayUser.value != null && cacheUser.value != null) {
      DocumentReference notifRef =
          _db.collection("/profile").doc(otherId).collection("notification").doc();
      await notifRef.set({
        "date" : DateTime.now(),
        "event" : "following you",
        "photo_path": cacheUser.value!.photoPath,
        "read": false,
        "u_name": cacheUser.value!.uName
      });
    }
  }

  // profile
  readProfile({bool update = false}) {
    // state.value = ProfileState.loading;
    if (cacheUser.value != null) {
      state.value = ProfileState.loading;
      displayUser.value = cacheUser.value;
      cacheUser.value = null;
      state.value = ProfileState.done;
    } else {
      fetchData(_uId);
    }
  }

  readOtherProfile(String otherId) {
    state.value = ProfileState.loading;
    if (cacheUser.value == null && displayUser.value != null) {
      cacheUser.value = displayUser.value;
    }
    if (cacheUser.value != null) {
      followed.value = cacheUser.value!.following.contains(otherId);
    }
    fetchData(otherId);
  }

  followProfile(String otherId) {
    if (cacheUser.value != null) {
      followed.value = true;
      cacheUser.value!.following.add(otherId);
      addNotif(otherId);
      followFun(otherId, false);
    }
  }

  unFollowProfile(String otherId) {
    if (cacheUser.value != null) {
      followed.value = false;
      if (cacheUser.value!.following.contains(otherId)) {
        cacheUser.value!.following.remove(otherId);
        followFun(otherId, true);
      }
    }
  }

  followFun(String otherId, bool unfollow) async {
    WriteBatch batch = _db.batch();
    DocumentReference profileRef = _db.collection("/profile").doc(_uId);
    DocumentReference otherProfileRef = _db.collection("/profile").doc(otherId);
    if (!unfollow) {
      batch.update(profileRef, {
        "following": FieldValue.arrayUnion([otherId])
      });
      batch.update(otherProfileRef, {
        "follower": FieldValue.arrayUnion([_uId])
      });
    } else {
      batch.update(profileRef, {
        "following": FieldValue.arrayRemove([otherId])
      });
      batch.update(otherProfileRef, {
        "follower": FieldValue.arrayRemove([_uId])
      });
    }
    await batch.commit();
  }

  fetchData(String id) async {
    recentState.value = RecentMovieState.loading;
    CollectionReference filmReviewRef = _db.collection("/film_review");
    DocumentReference<Map<String, dynamic>> profileRef =
        _db.collection("/profile").doc(id);
    QuerySnapshot<Map<String, dynamic>> recentWatch = await profileRef
        .collection("recent")
        .orderBy("date", descending: true)
        .get();
    QuerySnapshot<Map<String, dynamic>> recentReview =
        await getRecentReview(uId: id);
    await profileRef.get().then((value) async {
      ProfileModel data = ProfileModel.fromFirestore(
          value,
          recentWatch,
          ReviewModel.fromFirestore(recentReview, null).reviewData,
          SnapshotOptions());
      displayUser.value = data;
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
    WriteBatch batch = _db.batch();
    bool check = false;
    for (var element in data.recentRev!) {
      if (data.photoPath != element.photoPath) {
        check = true;
      }
    }
    if (check) {
      for (var filmRevId in data.reviewRef) {
        batch.update(
            filmReviewRef.doc("$filmRevId").collection("review").doc(_uId),
            {"u_name": data.uName, "photo_path": data.photoPath});
      }
    }
    for (var filmRev in data.recentRev!) {
      List listOfId = [];
      if (!data.reviewRef.contains(filmRev.filmInfoModel.filmId)) {
        listOfId.add(filmRev.filmInfoModel.filmId);
      }
      batch.update(profileRef, {"review_ref": FieldValue.arrayUnion(listOfId)});
    }
    await batch.commit();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRecentReview(
      {required String uId}) async {
    QuerySnapshot<Map<String, dynamic>> reviewData = await _db
        .collectionGroup("review")
        .where("u_id", whereIn: [uId])
        .orderBy("date", descending: true)
        .get();

    return reviewData;
  }

  imgPicker() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      SettableMetadata imgMetadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': image.path});
      Reference storageRef = _storage.ref("profile_images/").child("$_uId.jpg");
      await storageRef.putFile(File(image.path), imgMetadata);
      await storageRef.getDownloadURL().then((value) {
        _db.collection("/profile").doc(_uId).update({"photo_path": value});
      });
      readProfile(update: true);
    }
  }
}

enum ProfileState { loading, done, error }

enum RecentMovieState { loading, done, error }

enum RecentReviewState { loading, done, error }
