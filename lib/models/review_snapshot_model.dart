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
  final String? filmPosterPath;
  final String? filmBackdropPath;
  final String? filmTitle;
  final DateTime? filmYear;
  final String uId;
  final String uName;
  final DateTime reviewDate;
  final double rate;
  final String reviewText;
  final String photoPath;

  ReviewEntityModel(
      {this.filmPosterPath,
      this.filmBackdropPath,
      this.filmTitle,
      this.filmYear,
      required this.uId,
      required this.uName,
      required this.reviewDate,
      required this.rate,
      required this.reviewText,
      required this.photoPath});

  factory ReviewEntityModel.fromFirestore(
    Map<String, dynamic> data,
    Map<String, dynamic>? dataFilm,
  ) {
    return ReviewEntityModel(
      filmPosterPath: dataFilm != null ? dataFilm["poster_path"] : null,
      filmBackdropPath: dataFilm != null ? dataFilm["backdrop_path"] : null,
      filmTitle: dataFilm != null ? dataFilm["title"] : null,
      filmYear: dataFilm != null
          ? (dataFilm["year_release"] as Timestamp).toDate()
          : null,
      uId: data['u_id'],
      uName: data['u_name'],
      reviewDate: (data['date'] as Timestamp).toDate(),
      rate: (data['rate'] as num).toDouble(),
      reviewText: data['review'],
      photoPath: data['photo_path'],
    );
  }
}
