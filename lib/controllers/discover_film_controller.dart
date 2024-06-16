import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/tmdb_services.dart';
import 'package:letterboxd_porto_3/models/genre_model.dart';
import 'package:letterboxd_porto_3/models/movie_list_model.dart';
import 'package:letterboxd_porto_3/models/sortby_model.dart';

import '../views/widgets/option_dialog.dart';

class DiscoverFilmController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<SortBy> listSort = [
    SortBy(name: "Most Popular", method: "popularity.desc"),
    SortBy(name: "Least Popular", method: "popularity.asc"),
    SortBy(name: "High Rated", method: "vote_average.desc"),
    SortBy(name: "Low Rated", method: "vote_average.asc")
  ];
  final TMDBServices _services = TMDBServices();
  final Rx<DiscoverState> state = DiscoverState.initial.obs;
  final Rx<OptionState> optionState = OptionState.loading.obs;

  final Rx<TextEditingController> searchText = TextEditingController().obs;
  late Rx<TabController> tabController;
  final Rxn<MovieData> resultMovie = Rxn();
  final Rx<GenreListModel?> listGenre = Rx(null);
  final RxList<Genre> selectedGenre = <Genre>[].obs;
  final Rxn<SortBy> selectedSort = Rxn();
  final int _delayTime = 800;
  final int _delayTimeGenre = 1200;

  Timer? _delayTimer;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this).obs;
    tabController.value.addListener(() {
      if (tabController.value.indexIsChanging) {
      }
    });
    getListGenre();
    super.onInit();
  }

  @override
  void onClose() {
    searchText.value.dispose();
    super.onClose();
  }

  getListGenre() async {
    optionState.value = OptionState.loading;
    listGenre.value = await _services.getGenreLisst();
    if (listGenre.value != null) {
      optionState.value = OptionState.done;
    } else {
      optionState.value = OptionState.error;
    }
  }

  String getGenreName(int id) {
    return listGenre.value?.genreData
            .firstWhereOrNull((element) => element.id == id)
            ?.name ??
        "";
  }

  String getGenreListRemainder(List genreIds) {
    if (genreIds.length > 3) {
      return "+${genreIds.length - 3}";
    } else {
      return "";
    }
  }

  selectGenre(Genre data) {
    if (selectedGenre.any((element) => element.id == data.id)) {
      selectedGenre.remove(data);
    } else {
      selectedGenre.add(data);
    }
    inspect(selectedGenre);
  }

  removeGenre(Genre data) {
    if (selectedGenre.any((element) => element == data)) {
      selectedGenre.remove(data);
    }
  }

  clearGenre() {
    selectedGenre.clear();
    update();
  }

  bool checkGenre(Genre data) {
    if (selectedGenre.any((element) => element == data)) {
      return true;
    } else {
      return false;
    }
  }

  selectSort(SortBy data) async {
    if (selectedSort.value == data) {
      selectedSort.value = null;
    } else {
      selectedSort.value = data;
    }
  }

  clearSort() {
    selectedSort.value = null;
  }

  bool checkSort(SortBy data) {
    if (selectedSort.value != null && selectedSort.value == data) {
      return true;
    } else {
      return false;
    }
  }

  Future advanceSearch() async {
    state.value = DiscoverState.loading;
    List genre = List.from(selectedGenre.map((e) => e.id));
    resultMovie.value = await _services.getMovieOfTheMonth(
        sortBy: selectedSort.value?.method, genreList: genre);
    if (resultMovie.value == null) {
      state.value = DiscoverState.error;
    } else if (resultMovie.value!.results.isEmpty) {
      state.value = DiscoverState.empty;
    } else if (resultMovie.value!.results.isNotEmpty) {
      state.value = DiscoverState.done;
    } else {
      state.value = DiscoverState.error;
    }
  }

  void searchByTitle() async {
    state.value = DiscoverState.loading;
    if (selectedGenre.isNotEmpty || selectedSort.value != null) {
      List<Result> data;
      await advanceSearch();
      if (resultMovie.value != null) {
        data = resultMovie.value!.results
            .where((element) => element.title
                .toLowerCase()
                .contains(searchText.value.text.toLowerCase()))
            .toList();
        resultMovie.value = MovieData(
            page: resultMovie.value!.page,
            results: data,
            totalPages: resultMovie.value!.totalPages,
            totalResults: resultMovie.value!.totalResults);
      }
    } else {
      resultMovie.value =
          await _services.getMovieByTitle(text: searchText.value.text);
      inspect(resultMovie.value);
    }
    if (resultMovie.value == null) {
      state.value = DiscoverState.error;
    } else if (resultMovie.value!.results.isNotEmpty) {
      state.value = DiscoverState.done;
    } else if (resultMovie.value!.results.isEmpty) {
      state.value = DiscoverState.empty;
    } else {
      state.value = DiscoverState.error;
    }
  }

  void debounceSearch() {
    if (_delayTimer?.isActive ?? false) {
      _delayTimer!.cancel();
    }
    state.value = DiscoverState.loading;
    _delayTimer = Timer(Duration(milliseconds: _delayTime), () {
      if (searchText.value.text.isNotEmpty) {
        searchByTitle();
      } else {
        state.value = DiscoverState.initial;
      }
    });
  }

  void debounceSearchByGenre() {
    if (_delayTimer?.isActive ?? false) {
      _delayTimer!.cancel();
    }
    state.value = DiscoverState.loading;
    _delayTimer = Timer(Duration(milliseconds: _delayTimeGenre), () {
      if (searchText.value.text.isNotEmpty) {
        searchByTitle();
      } else if (selectedGenre.isNotEmpty || selectedSort.value != null) {
        advanceSearch();
      } else {
        state.value = DiscoverState.initial;
      }
    });
  }

  void openOptionDialog() {
    Get.dialog(const OptionDialog()).then((value) {
      if (searchText.value.text.isNotEmpty) {
        searchByTitle();
      } else if (selectedSort.value != null || selectedGenre.isNotEmpty) {
        advanceSearch();
      } else {
        resultMovie.value = null;
        state.value = DiscoverState.initial;
      }
    });
  }
}

enum DiscoverState { initial, empty, loading, done, error }

enum OptionState { loading, done, error }
