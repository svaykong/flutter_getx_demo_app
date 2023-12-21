import 'movie_type.dart';

class MovieModel {
  MovieModel(
    this._movieType, {
    required this.id,
    required this.originalTitle,
    required this.backdropPath,
  });

  final int id;
  final String originalTitle;
  final String backdropPath;
  MovieType _movieType;

  MovieType get movieType => _movieType;

  set movieType(MovieType value) => _movieType = value;

  factory MovieModel.fromMap(Map<String, dynamic> json) => MovieModel(
        MovieType.UNKNOWN,
        id: json['id'],
        originalTitle: json['original_title'],
        backdropPath: json['backdrop_path'] ?? json['poster_path'],
      );
}
