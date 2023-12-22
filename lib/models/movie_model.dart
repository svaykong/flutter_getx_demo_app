import 'package:intl/intl.dart';

import 'base_type.dart';

class MovieModel {
  MovieModel({
    required this.movieType,
    required this.results,
    required this.page,
    required this.totalPages,
  });

  final BaseType movieType;
  List<ResultModel> results;
  final int page;
  final int totalPages;

  factory MovieModel.fromMap(Map<String, dynamic> json, BaseType movieType) {
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
    required this.releaseDate,
  });

  final int id;
  final String originalTitle;
  final String backdropPath;
  final String releaseDate;

  String get getReleaseDateISO {
    DateFormat dateFormat = DateFormat.yMMMMd();
    var formattedDate = dateFormat.format(DateTime.parse(releaseDate));
    return formattedDate.toString();
  }

  factory ResultModel.fromMap(Map<String, dynamic> json) => ResultModel(
        id: json['id'],
        originalTitle: json['original_title'] ?? json['original_name'],
        backdropPath: json['backdrop_path'] ?? json['poster_path'],
        releaseDate: json['release_date'] ?? json['first_air_date'],
      );
}
