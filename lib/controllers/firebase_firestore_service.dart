// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:letterboxd_porto_3/controllers/firebase_auth_services.dart';

// class FireStoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final String uId = FirebaseAuthService().userId ?? "";

//   ///width of poster consist of [92, 154, 185, 342, 500, 700]
//   ///
//   ///width of backdrop consist of [300, 780, 1280]
//   ///
//   ///width of profile consist of [45, 185, 632]
//   String imgUrl({
//     required String pathUrl,
//     int? width,
//   }) {
//     try {
//       if (pathUrl == "") {
//         return "";
//       }
//       return "https://image.tmdb.org/t/p/w${width ?? 185}/$pathUrl";
//     } catch (e) {}
//   }
// }
