import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final List<ReviewEntityModel> reviewData;
  ReviewModel({required this.reviewData});
  factory ReviewModel.fromFirestore(
    QuerySnapshot<Map<String, dynamic>> review,
    DocumentSnapshot<Map<String, dynamic>>? film,
  ) {
    final data = review.docs;
    final filmData = film?.data();
    return ReviewModel(
        reviewData: List.from(data.map<ReviewEntityModel>(
            (e) => ReviewEntityModel.fromFirestore(e.data(), filmData))));
  }
}

class ReviewEntityModel {
  final String uId;
  final String uName;
  final DateTime reviewDate;
  final double rate;
  final String reviewText;
  final String photoPath;
  final FilmInfoModel filmInfoModel;

  ReviewEntityModel(
      {required this.uId,
      required this.uName,
      required this.reviewDate,
      required this.rate,
      required this.reviewText,
      required this.photoPath,
      required this.filmInfoModel});

  factory ReviewEntityModel.fromFirestore(
    Map<String, dynamic> data,
    Map<String, dynamic>? dataFilm,
  ) {
    print("sad");
    print(data["film_info"]);
    return ReviewEntityModel(
      uId: data['u_id'],
      uName: data['u_name'],
      reviewDate: (data['date'] as Timestamp).toDate(),
      rate: (data['rate'] as num).toDouble(),
      reviewText: data['review'],
      photoPath: data['photo_path'],
      filmInfoModel: FilmInfoModel.fromFirestore(data["film_info"])
    );
  }
}

class FilmInfoModel {
  final String? filmPosterPath;
  final String? filmBackdropPath;
  final String? filmTitle;
  final DateTime? filmYear;

  FilmInfoModel({
    this.filmPosterPath,
    this.filmBackdropPath,
    this.filmTitle,
    this.filmYear,
  });

  factory FilmInfoModel.fromFirestore(
    Map<String, dynamic> data,
  ) {
    return FilmInfoModel(
        filmPosterPath: data["poster_path"],
        filmBackdropPath: data["backdrop_path"],
        filmTitle: data["title"],
        filmYear: (data["year_release"] as Timestamp).toDate());
  }
}
