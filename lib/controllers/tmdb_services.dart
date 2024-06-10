import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:letterboxd_porto_3/envied_helper.dart';
import 'package:letterboxd_porto_3/models/genre_model.dart';

import '../models/movie_cast_model.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_list_model.dart';

class TMDBServices {
  final String _mainURL = "https://api.themoviedb.org/3/";
  DateTime dateNow = DateTime.now();
  final Dio _dio = Dio();

  ///width of poster consist of [92, 154, 185, 342, 500, 700]
  ///
  ///width of backdrop consist of [300, 780, 1280]
  ///
  ///width of profile consist of [45, 185, 632]
  String imgUrl({
    required String pathUrl,
    int? width,
  }) {
    if (pathUrl == "") {
      return "";
    }
    return "https://image.tmdb.org/t/p/w${width ?? 185}/$pathUrl";
  }

  Future<MovieData?> getMovieOfTheMonth({
    DateTime? date,
    String? sortBy,
    List? genreList,
    int page = 1,
  }) async {
    dateNow = date ?? dateNow;
    String sort = "";
    String genre = "";
    String dateGte = DateFormat("yyyy-MM").format(dateNow);
    String dateLte = DateFormat("yyyy-MM").format(
      DateTime(dateNow.year, dateNow.month + 1),
    );
    if (sortBy == "vote") {
      sort = "vote_average.desc&vote_count.gte=10";
    } else {
      sort = "popularity.desc";
    }
    if (genreList != null) {
      genre = "&with_genres=${genreList.join("%2C")}";
    }
    String url =
        "discover/movie?page=$page&primary_release_date.gte=$dateGte-01&primary_release_date.lte=$dateLte-1&sort_by=$sort$genre";
    try {
      Response data = await _dio.get(
        "$_mainURL$url",
        options: Options(headers: {'Authorization': 'Bearer ${Env.apiKey}'}),
      );
      print(data.statusCode);
      if (data.statusCode == 200) {
        print("it return");
        print(data.data);
        return MovieData.fromJson(data.data);
      }
      return null;
    } catch (e) {
      print("Error");
      print(e);
      return null;
    }
  }

  Future<MovieData?> getMovieByTitle({
    required String text,
    String? year,
    int page = 1,
  }) async {
    String release = "";
    DateTime now = DateTime.now();
    if (year != null) {
      release = "primary_release_year=$year";
    }else{
      release = "primary_release_year=${now.year-1}";
    }
    String url = "search/movie?query=$text&page=$page&$release";
    try {
      Response data = await _dio.get("$_mainURL$url", 
        options: Options(headers: {'Authorization': 'Bearer ${Env.apiKey}'}),
      );
      if (data.statusCode == 200) {
        return MovieData.fromJson(data.data);
      }
      return null;
    } catch (e) {
      print("error");
      print(e);
      return null;
    }
  }

  Future<MovieDetail?> getMovieDetail({required int id}) async {
    String url = "movie/$id";

    try {
      Response data = await _dio.get(
        "$_mainURL$url",
        options: Options(headers: {'Authorization': 'Bearer ${Env.apiKey}'}),
      );
      if (data.statusCode == 200) {
        print(data.data);
        return MovieDetail.fromJson(data.data);
      }
      return null;
    } catch (e) {
      print("errors");
      print(e);
      return null;
    }
  }

  Future<MovieCast?> getMovieCast({required int id}) async {
    String url = "movie/$id/credits";

    try {
      Response data = await _dio.get(
        "$_mainURL$url",
        options: Options(headers: {'Authorization': 'Bearer ${Env.apiKey}'}),
      );
      if (data.statusCode == 200) {
        return MovieCast.fromJson(data.data);
      }
      return null;
    } catch (e) {
      print("error");
      print(e);
      return null;
    }
  }

  Future<GenreListModel?> getGenreLisst() async {
    String url = "genre/movie/list";
    try {
      Response data = await _dio.get(
        "$_mainURL$url",
        options: Options(headers: {'Authorization': 'Bearer ${Env.apiKey}'}),
      );
      if (data.statusCode == 200) {
        return GenreListModel.fromJson(data.data);
      }
      return null;
    } catch (e) {
      print("error genre");
      print(e);
      return null;
    }
  }
}
