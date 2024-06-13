import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/discover_film_controller.dart';
import 'package:letterboxd_porto_3/models/profile_model.dart';

class DiscoverPeopleController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final RxList<ProfileModel> listPeople = <ProfileModel>[].obs;
  final Rx<DiscoverPeopleState> state = DiscoverPeopleState.initial.obs;
  final DiscoverFilmController _discoverFilmController =
      Get.find<DiscoverFilmController>();
  Timer? _delayTimer;
  int _delayTime = 800;

  searchByName() async {
    state.value = DiscoverPeopleState.loading;
    Query<Map<String, dynamic>> profileRef = _db
        .collection("/profile")
        .orderBy("u_name")
        .startAt([_discoverFilmController.searchText.value.text.toLowerCase()]).endAt(
            ["${_discoverFilmController.searchText.value.text.toLowerCase()}\uf8ff"]);
    var data = await profileRef.get();
    listPeople.value = data.docs
        .map(
            (e) => ProfileModel.fromFirestore(e, null, null, SnapshotOptions()))
        .toList();
    if (listPeople.isNotEmpty) {
      state.value = DiscoverPeopleState.done;
    }
    else if(listPeople.isEmpty){
      state.value = DiscoverPeopleState.empty;
    }
    else{
      state.value = DiscoverPeopleState.error;
    }
  }

  void debounceSearch() {
    if (_delayTimer?.isActive ?? false) {
      _delayTimer!.cancel();
    }
    state.value = DiscoverPeopleState.loading;
    _delayTimer = Timer(Duration(milliseconds: _delayTime), () {
      print("search people!!");
      if (_discoverFilmController.searchText.value.text.isNotEmpty) {
        searchByName();
      } else {
        state.value = DiscoverPeopleState.initial;
      }
    });
  }
}

enum DiscoverPeopleState { initial, empty, loading, error, done }
