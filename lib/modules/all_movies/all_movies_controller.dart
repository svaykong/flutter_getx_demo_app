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
  List<ResultModel> allMovies = [];
  bool isLoading = true;
  String errMsg = '';
  BaseType? movieType;

  void init(BaseType value) {
    movieType = value;
  }

  Future<List<ResultModel>> loadMore(int nextPage) async {
    'loadMore nextPage: $nextPage called...'.log();
    isLoading = true;

    final tmpMovies = <ResultModel>[];
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
    tmpMovies.addAll(movieModel.results); // add result next page
    currentPage = nextPage + 1;

    isLoading = false;
    update();

    'loadMore finally...'.log();
    return tmpMovies;
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
      /*
      for (int pageCount = 2; totalPages > 0; pageCount++) {
        // if pageCount reached to page 3 then we will stop
        if (pageCount == 3) {
          break;
        }

        if (movieType == BaseType.POPULAR_MOVIE) {
          response = await _movieApi.getPopularMoviesByPage(pageNum: pageCount);
        } else if (movieType == BaseType.POPULAR_TVSHOWS) {
          response = await _tvShowsApi.getPopularTVShowsByPage(pageNum: pageCount);
        } else if (movieType == BaseType.TOPRATED_TVSHOWS) {
          response = await _tvShowsApi.getTopRatedTVShowsByPage(pageNum: pageCount);
        } else {
          response = await _movieApi.getTopRatedMoviesByPage(pageNum: pageCount);
        }

        movieModel = MovieModel.fromMap(response, movieType!);
        allMovies.addAll(movieModel.results); // add result with other pages
      }
      */
    } catch (e) {
      'fetchAllMovies exception: $e'.log();
      errMsg = e.toString();
      isLoading = false;
    } finally {
      isLoading = false;
      update();
    }
  }
}
