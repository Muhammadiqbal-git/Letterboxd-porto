import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letterboxd_porto_3/models/review_snapshot_model.dart';

class ProfileModel {
  final String uId;
  final String uName;
  final String photo_path;
  final List<dynamic> following;
  final List<dynamic> follower;
  final Map<String, dynamic> favorite;
  final List<RecentMovieModel>? recentMovie;
  final List<ReviewEntityModel>? recentRev;

  ProfileModel(
      {required this.uId,
      required this.uName,
      required this.photo_path,
      required this.following,
      required this.follower,
      required this.favorite,
      required this.recentMovie,
      required this.recentRev
      });
  factory ProfileModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      QuerySnapshot<Map<String, dynamic>>? recent,
      List<ReviewEntityModel>? recentReview,
      SnapshotOptions? options) {
    final data = snapshot.data();
    final rec = recent?.docs;
    return ProfileModel(
      uId: snapshot.id,
      uName: data?['u_name'],
      photo_path: data?['photo_path'],
      following: data?['follower'],
      follower: data?['follower'],
      favorite: data?['favorite'],
      recentMovie: rec != null
          ? List<RecentMovieModel>.from(
              rec.map<RecentMovieModel>(
                  (e) => RecentMovieModel.fromFirestore(e.id, e.data())),
            )
          : null,
      recentRev:  recentReview
    );
  }
  Map<String, Object?> toFirestore() {
    return {
      'u_name': uName,
      'photo_path': photo_path,
      'following': following,
      'follower': follower,
      'favorite': favorite,
    };
  }
}

class RecentMovieModel {
  String id;
  DateTime? date;
  double rate;
  String review;
  String? posterPath;
  RecentMovieModel({
    required this.id,
    required this.date,
    required this.rate,
    required this.review,
    required this.posterPath,
  });

  factory RecentMovieModel.fromFirestore(String id, Map<String, dynamic> data) {
    return RecentMovieModel(
        id: id,
        date: data['date'] is Timestamp
            ? (data['date'] as Timestamp).toDate()
            : null,
        rate: (data['rate'] as num).toDouble(),
        review: data['review'],
        posterPath: data['poster_path']);
  }
}
// class Favorite{
//   final String filmId;

//   Favorite({required this.filmId});
//   factory Favorite.fromJson(Map<String ,dynamic> json) => Favi
// }
