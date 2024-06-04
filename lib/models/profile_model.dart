import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String uId;
  final String uName;
  final String photo_path;
  final int following;
  final int follower;
  final Map<String, dynamic>? favorite;
  final List<RecentMovieModel>? rec;

  ProfileModel(
      {required this.uId,
      required this.uName,
      required this.photo_path,
      required this.following,
      required this.follower,
      this.favorite,
      this.rec});
  factory ProfileModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      QuerySnapshot? recent, SnapshotOptions? options) {
    final data = snapshot.data();
    final rec = recent?.docs;
    return ProfileModel(
        uId: snapshot.id,
        uName: data?['u_name'],
        photo_path: data?['photo_path'],
        following: data?['follower'],
        follower: data?['follower'],
        favorite: data?['favorite'] is Map ? data!['favorite'] : null,
        rec: rec != null
            ? List.from(rec.map((e) => RecentMovieModel.fromFirestore(
                e.id, e.data() as Map<String, dynamic>)))
            : null);
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
  RecentMovieModel(
      {required this.id,
      required this.date,
      required this.rate,
      required this.review});

  factory RecentMovieModel.fromFirestore(String id, Map<String, dynamic> data) {
    return RecentMovieModel(
        id: id,
        date: data['date'] is Timestamp
            ? (data['date'] as Timestamp).toDate()
            : null,
        rate: (data['rate'] as num).toDouble(),
        review: data['review']);
  }
}
// class Favorite{
//   final String filmId;

//   Favorite({required this.filmId});
//   factory Favorite.fromJson(Map<String ,dynamic> json) => Favi
// }
