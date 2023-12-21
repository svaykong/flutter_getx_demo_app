import 'movie_type.dart';

class MovieModel {
  MovieModel({
    required this.movieType,
    required this.results,
    required this.page,
    required this.totalPages,
  });

  final MovieType movieType;
  List<ResultModel> results;
  final int page;
  final int totalPages;

  factory MovieModel.fromMap(Map<String, dynamic> json, MovieType movieType) {
    final results = List.from(json['results']).map((result) => ResultModel.fromMap(result)).toList();
    return MovieModel(
      movieType: movieType,
      results: results,
      page: json['page'],
      totalPages: json['total_pages'],
    );
  }
}

class ResultModel {
  const ResultModel({
    required this.id,
    required this.originalTitle,
    required this.backdropPath,
  });

  final int id;
  final String originalTitle;
  final String backdropPath;

  factory ResultModel.fromMap(Map<String, dynamic> json) => ResultModel(
        id: json['id'],
        originalTitle: json['original_title'],
        backdropPath: json['backdrop_path'] ?? json['poster_path'],
      );
}
