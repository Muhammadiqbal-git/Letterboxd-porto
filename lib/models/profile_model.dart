import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letterboxd_porto_3/models/review_snapshot_model.dart';

class NotificationModel {
  final List<NotificationEntityModel> listNotif;
  NotificationModel({required this.listNotif});
  factory NotificationModel.fromFirestore(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.docs;
    {
      return NotificationModel(
          listNotif: List.from(
              data.map((e) => NotificationEntityModel.fromFirestore(e))));
    }
  }
}

class NotificationEntityModel {
  final String docId;
  final String uId;
  final DateTime date;
  final String event;
  final String? photoPath;
  final String uName;
  final bool read;
  NotificationEntityModel(
      {required this.docId,
      required this.uId,
      required this.date,
      required this.event,
      required this.photoPath,
      required this.read,
      required this.uName});
  factory NotificationEntityModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot) {
    final data = docSnapshot.data();
    final id = docSnapshot.id;
    return NotificationEntityModel(
        docId: id,
        uId: data["u_id"] ?? "",
        date: (data["date"] as Timestamp).toDate(),
        event: data["event"],
        photoPath: data["photo_path"] ?? "",
        read: data["read"],
        uName: data["u_name"]);
  }
}

class ProfileModel {
  final String uId;
  final String uName;
  final String photoPath;
  final String bgPath;
  final List<dynamic> following;
  final List<dynamic> follower;
  final Map<String, dynamic> topFav;
  final List<RecentMovieModel>? recentMovie;
  final List<ReviewEntityModel>? recentRev;
  final List<dynamic> reviewRef;

  ProfileModel(
      {required this.uId,
      required this.uName,
      required this.photoPath,
      required this.bgPath,
      required this.following,
      required this.follower,
      required this.topFav,
      required this.recentMovie,
      required this.recentRev,
      required this.reviewRef});
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
      photoPath: data?['photo_path'] ?? "",
      bgPath: data?['bg_path'] ?? "",
      following: data?['following'],
      follower: data?['follower'],
      topFav: data?['top_fav'] ?? {},
      recentMovie: rec != null
          ? List<RecentMovieModel>.from(
              rec.map<RecentMovieModel>(
                  (e) => RecentMovieModel.fromFirestore(e.id, e.data())),
            )
          : null,
      recentRev: recentReview,
      reviewRef: data?['review_ref'],
    );
  }
  Map<String, Object?> toFirestore() {
    return {
      'u_name': uName,
      'photo_path': photoPath,
      'following': following,
      'follower': follower,
      'top_fav': topFav,
    };
  }
}

class RecentMovieModel {
  final String id;
  final DateTime? date;
  final double rate;
  final String? posterPath;
  RecentMovieModel({
    required this.id,
    required this.date,
    required this.rate,
    required this.posterPath,
  });

  factory RecentMovieModel.fromFirestore(String id, Map<String, dynamic> data) {
    return RecentMovieModel(
        id: id,
        date: data['date'] is Timestamp
            ? (data['date'] as Timestamp).toDate()
            : null,
        rate: (data['rate'] as num).toDouble(),
        posterPath: data['poster_path']);
  }
}

class FavoriteModel {
  final int filmId;
  final String? posterPath;
  final List<String> genreName;
  final String director;
  final String title;
  final DateTime releaseDate;
  int order;
  FavoriteModel(
      {required this.filmId,
      required this.posterPath,
      required this.genreName,
      required this.director,
      required this.title,
      required this.order,
      required this.releaseDate,
      });
  factory FavoriteModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot) {
    return FavoriteModel(
        filmId: docSnapshot["film_id"],
        posterPath: docSnapshot["poster_path"],
        genreName: docSnapshot["genre"].cast<String>(),
        director: docSnapshot["director"],
        order: docSnapshot["order"],
        title: docSnapshot["title"],
        releaseDate: (docSnapshot["year_release"] as Timestamp).toDate()
        );
  }
}
// class Favorite{
//   final String filmId;

//   Favorite({required this.filmId});
//   factory Favorite.fromJson(Map<String ,dynamic> json) => Favi
// }
