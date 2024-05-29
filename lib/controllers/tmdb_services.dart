import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:letterboxd_porto_3/envied_helper.dart';
import 'package:letterboxd_porto_3/models/movie_list_model.dart';

class TMDBServices {
  final String _mainURL = "https://api.themoviedb.org/3/";
  DateTime dateNow = DateTime.now();
  final Dio _dio = Dio();

  String imgUrl({required String pathUrl, int? width}){
    return "https://image.tmdb.org/t/p/w${width ?? 185}/$pathUrl";
  }
  Future<MovieData?> getMovieOfTheMonth({DateTime? date}) async {
    dateNow = date ?? dateNow;
    String dateGte = DateFormat("yyyy-MM").format(dateNow);
    String dateLte = DateFormat("yyyy-MM").format(DateTime(dateNow.year, dateNow.month+1));

    print(dateGte);
    String url =
        "discover/movie?primary_release_date.gte=$dateGte-01&primary_release_date.lte=$dateLte-1&sort_by=popularity.desc";
    print(url);
    try {
      Response data = await _dio.get("$_mainURL$url",
          options: Options(headers: {'Authorization': 'Bearer ${Env.apiKey}'}));
      if (data.statusCode == 200) {
        print(data.data);
        return MovieData.fromJson(data.data);
      }
        print(data.data);

      return null;
    } catch (e) {
      print("error");
      print(e);
      return null;
    }
  }
}
