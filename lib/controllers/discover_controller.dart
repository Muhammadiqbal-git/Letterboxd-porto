import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/tmdb_services.dart';
import 'package:letterboxd_porto_3/models/genre_model.dart';
import 'package:letterboxd_porto_3/models/movie_list_model.dart';
import 'package:letterboxd_porto_3/models/sortby_model.dart';

class DiscoverController extends GetxController {
  final List<SortBy> listSort = [
    SortBy(name: "Most Popular", method: "popularity.desc"),
    SortBy(name: "Least Popular", method: "popularity.asc"),
    SortBy(name: "High Rated", method: "vote_average.desc"),
    SortBy(name: "Low Rated", method: "vote_average.asc")
  ];
  final TMDBServices _services = TMDBServices();
  final Rx<DiscoverState> state = DiscoverState.loading.obs;
  final Rx<OptionState> optionState = OptionState.loading.obs;

  final Rx<TextEditingController> searchText = TextEditingController().obs;
  final Rx<MovieData?> resultMovie = Rx(null);
  final Rx<GenreListModel?> listGenre = Rx(null);
  final RxList<Genre> selectedGenre = <Genre>[].obs;
  final Rx<SortBy?> selectedSort = Rx(null);

  @override
  void onInit() {
    // TODO: implement onInit
    print("discovered");
    getGenre();
    super.onInit();
  }

  getGenre() async {
    optionState.value = OptionState.loading;
    listGenre.value = await _services.getGenreLisst();
    if (listGenre.value != null) {
      optionState.value = OptionState.done;
    } else {
      optionState.value = OptionState.error;
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

  void advanceSearch() async {
    state.value = DiscoverState.loading;
    List genre = List.from(selectedGenre.map((e) => e.id));
    resultMovie.value = await _services.getMovieOfTheMonth(
        sortBy: selectedSort.value?.method, genreList: genre);
    searchText.value.clear();
    if (resultMovie.value != null) {
      state.value = DiscoverState.done;
    } else {
      state.value = DiscoverState.error;
    }
  }

  void searchByTitle() async {
    state.value = DiscoverState.loading;
    resultMovie.value =
        await _services.getMovieByTitle(text: searchText.value.text);
    if (resultMovie.value != null) {
      state.value = DiscoverState.done;
    } else {
      state.value = DiscoverState.error;
    }
  }

  void openOptionDialog() {}
}

enum DiscoverState { loading, done, error }

enum OptionState { loading, done, error }
