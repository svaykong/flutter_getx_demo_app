import 'package:get/get.dart';

import '../../models/movie_model.dart';
import '../../apis/movie_api.dart';
import '../../models/movie_type.dart';
import '../../utils/logger.dart';

class AllMoviesController extends GetxController {
  MovieApi movieApi = MovieApi();
  List<ResultModel> allMovies = [];
  bool isLoading = true;
  String errMsg = '';
  MovieType? movieType;

  @override
  void onInit() {
    super.onInit();
    fetchAllMovies();
  }

  void init(MovieType value) {
    movieType = value;
  }

  void fetchAllMovies() async {
    try {
      if (movieType == null) {
        throw Exception("MovieType is null");
      }
      var response = await movieApi.getPopularMoviesByPage(pageNum: 1);
      if (response != null) {
        final movieModel = MovieModel.fromMap(response, movieType!);
        allMovies.addAll(movieModel.results);
        isLoading = false;
      }
    } catch (e) {
      'fetchAllMovies exception: $e'.log();
      errMsg = e.toString();
      isLoading = false;
    } finally {
      update();
    }
  }
}
