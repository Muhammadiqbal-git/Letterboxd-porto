import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final List<ReviewEntityModel> reviewData;
  ReviewModel({required this.reviewData});
  factory ReviewModel.fromFirestore(
    QuerySnapshot review,
  ) {
    final data = review.docs;
    return ReviewModel(
        reviewData: List.from(data.map((e) => ReviewEntityModel())));
  }
}

class ReviewEntityModel {
  final String? moviePosterPath;
  final String? movieBackdropPath;
  final String? movieTitle;
  final DateTime? movieYear;
  final String uId;
  final String uName;
  final DateTime reviewDate;
  final double rate;
  final String reviewText;
  final String photoPath;

  ReviewEntityModel(
      {this.moviePosterPath,
      this.movieBackdropPath,
      this.movieTitle,
      this.movieYear,
      required this.uId,
      required this.uName,
      required this.reviewDate,
      required this.rate,
      required this.reviewText,
      required this.photoPath});

  factory ReviewEntityModel.fromFirestore(
    QuerySnapshot<Map<String, dynamic>> data,
    DocumentSnapshot<Map<String, dynamic>> dataFilm,
  ) {
    data.d
    return ReviewEntityModel(
        uId: uId,
        uName: uName,
        reviewDate: reviewDate,
        rate: rate,
        reviewText: reviewText,
        photoPath: photoPath);
  }
}
