import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../routes/app_routes.dart';
import '../../shared_widgets/round_progress_bar.dart';
import '../../utils/constants.dart';
import '../../utils/logger.dart';
import 'search_movie_controller.dart';
import '../../models/movie_model.dart';

class MovieSearchDelegate extends SearchDelegate<String> {
  final _searchController = Get.find<SearchMovieController>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          /*
          if (query.isNotEmpty) {
            // close the search screen
            close(context, '');
          } else {
            // clear the query
            query = '';
          }
          */
          // clear the query
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const SizedBox.shrink();
    }

    if (query.length < 3) {
      return const Center(
        child: Text("Type at least 3 letters to search"),
      );
    }

    return Center(
      child: StreamBuilder(
          stream: _searchController.search(query: query),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snapshot.error.toString()),
                  );
                }
                final results = snapshot.data?.results ?? [];
                if (results.isEmpty) {
                  return const Text('Not found');
                }
                return _buildListResults(results);
            }
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    // return const SizedBox.shrink();

    if (query.isEmpty) {
      return const SizedBox.shrink();
    }

    if (query.length < 3) {
      return const Center(
        child: Text("Type at least 3 letters to search"),
      );
    }

    return Center(
      child: StreamBuilder(
          stream: _searchController.search(query: query),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snapshot.error.toString()),
                  );
                }
                final results = snapshot.data?.results ?? [];
                if (results.isEmpty) {
                  return const Text('Not found');
                }
                return _buildListResults(results);
            }
          }),
    );
  }

  Widget _buildListResults(List<ResultModel> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return results[index].backdropPath == null
            ? const SizedBox.shrink()
            : GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.movieDetails, arguments: [results[index].id]);
                },
                child: Card(
                  margin: const EdgeInsets.all(10.0),
                  clipBehavior: Clip.antiAlias,
                  elevation: 2.0,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          results[index].backdropPath == null
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Image not available'),
                                  ),
                                )
                              : CachedNetworkImage(
                                  placeholder: (_, __) => Container(color: Colors.grey[100]),
                                  imageUrl: '$imageBaseUrl${results[index].backdropPath}',
                                  fit: BoxFit.cover,
                                  height: Get.height * 0.30,
                                  width: double.infinity,
                                ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 20.0),
                            child: Text(
                              results[index].originalTitle,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: Text(
                              results[index].getReleaseDateISO,
                              textAlign: TextAlign.start,
                              style: const TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                        ],
                      ),
                      results[index].backdropPath == null
                          ? const SizedBox.shrink()
                          : Positioned(
                              bottom: 55,
                              left: 5,
                              child: RoundProgressBar(
                                percent: results[index].votPercent,
                              ),
                            ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
