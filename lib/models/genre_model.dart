class GenreListModel {
  List<Genre> genreData;
  GenreListModel({required this.genreData});
  factory GenreListModel.fromJson(Map<String, dynamic> json) => GenreListModel(
      genreData: List.from(json["genres"].map((e) => Genre.fromJson(e))));
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
