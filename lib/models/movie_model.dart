import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'base_type.dart';

class MovieModel extends Equatable {
  const MovieModel({
    required this.movieType,
    required this.results,
    required this.page,
    required this.totalPages,
  });

  final BaseType movieType;
  final List<ResultModel> results;
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

  @override
  List<Object?> get props => [
        movieType,
        results,
        page,
        totalPages,
      ];
}

class ResultModel extends Equatable {
  const ResultModel({
    required this.id,
    required this.originalTitle,
    this.backdropPath,
    required this.releaseDate,
    required this.votPercent,
  });

  final int id;
  final String originalTitle;
  final String? backdropPath;
  final String releaseDate;
  final int votPercent;

  String get getReleaseDateISO {
    if (releaseDate.isEmpty) {
      return '';
    }
    DateFormat dateFormat = DateFormat.yMMMMd();
    var formattedDate = dateFormat.format(DateTime.parse(releaseDate));
    return formattedDate.toString();
  }

  factory ResultModel.fromMap(Map<String, dynamic> json) {
    var voteAvg = double.tryParse(json['vote_average'].toString()) ?? 0;
    var voteCount = (voteAvg * 10).round();
    return ResultModel(
      id: json['id'],
      originalTitle: json['original_title'] ?? json['original_name'],
      backdropPath: json['backdrop_path'] ?? json['poster_path'],
      releaseDate: json['release_date'] ?? json['first_air_date'],
      votPercent: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        originalTitle,
        backdropPath,
        releaseDate,
        votPercent,
      ];
}
