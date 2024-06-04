import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letterboxd_porto_3/controllers/firebase_auth_services.dart';
import 'package:letterboxd_porto_3/models/profile_model.dart';

class ProfileController extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuthService _service = FirebaseAuthService();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  Rx<ProfileModel?> user = Rx<ProfileModel?>(null);
  Rx<String?> imgPath = "".obs;

  @override
  void onInit() {
    readProfile();
    super.onInit();
  }

  // profile
  readProfile({bool update = false}) async {
    String uId = _service.userId ?? "s";
    CollectionReference filmReviewRef = _db.collection("/film_review");
    DocumentReference<Map<String, dynamic>> profileRef =
        _db.collection("/profile").doc(uId);
    QuerySnapshot<Map<String, dynamic>> recent = await profileRef
        .collection("recent")
        .orderBy("date", descending: true)
        .get();
    DocumentSnapshot<Map<String, dynamic>> profile = await profileRef.get();
    if (profile.exists) {
      print("s");
      ProfileModel data =
          ProfileModel.fromFirestore(profile, recent, SnapshotOptions());
      user.value = data;
      imgPath.value = data.photo_path;
      if (update) {
        WriteBatch batch = _db.batch();
        for (var snapshot in recent.docs) {
          batch.update(
              filmReviewRef.doc(snapshot.id).collection("review").doc(uId),
              {"u_name": data.uName, "photo_path": data.photo_path});
        }
        await batch.commit().then((value) => print("success"));
      }
    }
  }

  imgPicker() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    String uId = _service.userId ?? "s";
    if (image != null) {
      SettableMetadata imgMetadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': image.path});
      Reference storageRef = _storage.ref("profile_images/").child("$uId.jpg");
      await storageRef.putFile(File(image.path), imgMetadata);
      await storageRef.getDownloadURL().then((value) {
        _db.collection("/profile").doc(uId).update({"photo_path": value});
        imgPath.value = value;
      });
      await readProfile(update: true);
    }
  }
}
