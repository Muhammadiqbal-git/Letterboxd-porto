import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/models/profile_model.dart';

import 'firebase_auth_services.dart';

class FavoriteController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  RxList<FavoriteModel> listFav = RxList<FavoriteModel>();
  Rx<ListFavoriteState> state = Rx(ListFavoriteState.empty);
  final String _uId = FirebaseAuthService().userId ?? "";

  @override
  void onInit() {
    // TODO: implement onInit
    readListFav();
    super.onInit();
  }

  @override
  void onClose() {
    updateOrder();
    super.onClose();
  }

  readListFav() async {
    state.value = ListFavoriteState.loading;
    listFav.value = [];
    final ref = await _db
        .collection("/profile")
        .doc(_uId)
        .collection("favorite")
        .orderBy("order", descending: false)
        .get();
    if (ref.docs.isEmpty) {
      state.value = ListFavoriteState.empty;
    } else {
      listFav.value =
          List.from(ref.docs.map((e) => FavoriteModel.fromFirestore(e)));
      state.value = ListFavoriteState.done;
      for (var e in listFav) {
        print(e.title);
        print(e.order);
      }
    }
  }

  changeOrder(int oldIndex, int newIndex) {
    final data = listFav.removeAt(oldIndex);
    if (oldIndex > newIndex) {
      listFav.insert(newIndex, data);
    } else {
      listFav.insert(newIndex - 1, data);
    }
  }

  updateOrder() {
    WriteBatch batch = _db.batch();
    Map<String, String> fav = {};
    if (listFav.isEmpty) {
      return;
    }
    int order = 1;
    for (var e in listFav) {
      e.order = order;
      if (order <= 4) {
        fav[e.filmId.toString()] = e.posterPath ?? "";
      }
      order++;
    }
    batch.update(_db.collection("/profile").doc(_uId), {"top_fav": fav});
    for (var e in listFav) {
      batch.update(
          _db
              .collection("/profile")
              .doc(_uId)
              .collection("favorite")
              .doc("${e.filmId}"),
          {"order": e.order});
    }
    batch.commit().then((value) => print("order changed"));
  }
    String getGenreListRemainder(List genres) {
    if (genres.length > 3) {
      return "+${genres.length - 3}";
    } else {
      return "";
    }
  }
}

enum ListFavoriteState { loading, done, empty }
