import 'dart:async';

import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/movie_model.dart';
import '../../apis/movie_api.dart';
import '../../utils/logger.dart';

class SearchMovieController extends GetxController {
  static const _serviceName = 'SearchMovieController';
  final MovieApi _movieApi = MovieApi();

  // Input stream (search terms)
  final BehaviorSubject<String> _searchSubject = BehaviorSubject<String>();

  void search(String query) => _searchSubject.add(query);

  // Output stream (search results)
  late Stream<MovieModel> _results;

  Stream<MovieModel> get results => _results;

  @override
  void onInit() {
    '$_serviceName onInit'.log();
    super.onInit();

    /* rxdart approach */
    _results = _searchSubject.debounceTime(const Duration(milliseconds: 500)).switchMap((query) async* {
      yield await _movieApi.searchMovie(query: query);
    });
  }

  @override
  void dispose() {
    '$_serviceName dispose'.log();
    // _searchTerms.close();
    super.dispose();
  }
}
