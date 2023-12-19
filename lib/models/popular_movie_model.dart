class PopularMovieModel {
  int id;
  String originalTitle;
  String backdropPath;

  PopularMovieModel({
    required this.id,
    required this.originalTitle,
    required this.backdropPath,
  });

  factory PopularMovieModel.fromMap(Map<String, dynamic> json) => PopularMovieModel(
    id: json['id'],
    originalTitle: json['original_title'],
    backdropPath: json['backdrop_path'] ?? json['poster_path'],
  );
}
