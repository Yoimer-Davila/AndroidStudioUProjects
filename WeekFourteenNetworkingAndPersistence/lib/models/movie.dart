class Movie {
  late int id;
  late String originalLanguage;
  late String overview;
  late double popularity;
  late String posterPath;
  late String releaseDate;
  late String title;
  bool isFavorite = false;
  Movie(this.id,
        this.originalLanguage,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title);

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    originalLanguage = json['original_language'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    return data;
  }

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title
  };


}
