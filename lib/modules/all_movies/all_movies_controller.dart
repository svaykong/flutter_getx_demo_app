import 'package:get/get.dart';

import '../../models/movie_model.dart';
import '../../apis/movie_api.dart';
import '../../apis/tvshows_api.dart';
import '../../models/base_type.dart';
import '../../utils/logger.dart';

class AllMoviesController extends GetxController {
  final MovieApi _movieApi = MovieApi();
  final TVShowsApi _tvShowsApi = TVShowsApi();

  int totalPages = 0;
  int currentPage = 1;
  RxList<ResultModel> allMovies = <ResultModel>[].obs;
  RxBool isLoading = true.obs;
  String errMsg = '';
  BaseType? movieType;

  void init(BaseType value) {
    movieType = value;
  }

  Future<void> loadMore(int nextPage) async {
    'loadMore nextPage: $nextPage called...'.log();
    isLoading(true);

    dynamic response;
    if (movieType == BaseType.POPULAR_MOVIE) {
      response = await _movieApi.getPopularMoviesByPage(pageNum: nextPage);
    } else if (movieType == BaseType.POPULAR_TVSHOWS) {
      response = await _tvShowsApi.getPopularTVShowsByPage(pageNum: nextPage);
    } else if (movieType == BaseType.TOPRATED_TVSHOWS) {
      response = await _tvShowsApi.getTopRatedTVShowsByPage(pageNum: nextPage);
    } else {
      response = await _movieApi.getTopRatedMoviesByPage(pageNum: nextPage);
    }
    MovieModel movieModel = MovieModel.fromMap(response, movieType!);
    allMovies.addAll(movieModel.results); // add result next page
    currentPage = nextPage + 1;

    isLoading(false);

    'loadMore finally...'.log();
  }

  Future<void> fetchAllMovies() async {
    allMovies.clear(); // remove the old data
    try {
      if (movieType == null) {
        throw Exception("MovieType is null");
      }

      dynamic response;
      if (movieType == BaseType.POPULAR_MOVIE) {
        response = await _movieApi.getPopularMoviesByPage(pageNum: 1);
      } else if (movieType == BaseType.POPULAR_TVSHOWS) {
        response = await _tvShowsApi.getPopularTVShowsByPage(pageNum: 1);
      } else if (movieType == BaseType.TOPRATED_TVSHOWS) {
        response = await _tvShowsApi.getTopRatedTVShowsByPage(pageNum: 1);
      } else {
        response = await _movieApi.getTopRatedMoviesByPage(pageNum: 1);
      }
      MovieModel movieModel = MovieModel.fromMap(response, movieType!);
      allMovies.addAll(movieModel.results); // add result page 1

      totalPages = int.tryParse(response["total_pages"].toString()) ?? 0;
    } catch (e) {
      'fetchAllMovies exception: $e'.log();
      errMsg = e.toString();
    } finally {
      isLoading(false);
      update();
    }
  }
}
