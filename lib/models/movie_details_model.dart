import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';

class MovieDetailsModel extends Equatable {
  const MovieDetailsModel({
    required this.backdropPath,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.releaseDate,
    required this.votePercent,
    required this.genres,
    required this.tagline,
  });

  final String backdropPath;
  final int id;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final int votePercent;
  final List<Genres> genres;
  final String tagline;

  String get getReleaseDateISO {
    if (releaseDate.isEmpty) {
      return '';
    }
    DateFormat dateFormat = DateFormat.yMMMMd();
    var formattedDate = dateFormat.format(DateTime.parse(releaseDate));
    return formattedDate.toString();
  }

  factory MovieDetailsModel.fromMap(Map<String, dynamic> json) {
    var voteAvg = double.tryParse(json['vote_average'].toString()) ?? 0;
    var voteCount = (voteAvg * 10).round();
    return MovieDetailsModel(
      backdropPath: json['backdrop_path'] ??= json['poster_path'],
      id: json['id'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      releaseDate: json['release_date'] ?? json['first_air_date'],
      votePercent: voteCount,
      genres: List.from(json['genres']).map((genre) => Genres.fromMap(genre)).toList(),
      tagline: json['tagline'],
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        originalTitle,
        overview,
        releaseDate,
        votePercent,
      ];
}

class Genres extends Equatable {
  const Genres({required this.id, required this.name});

  final int id;
  final String name;

  factory Genres.fromMap(Map<String, dynamic> json) => Genres(
        id: json['id'],
        name: json['name'],
      );

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
