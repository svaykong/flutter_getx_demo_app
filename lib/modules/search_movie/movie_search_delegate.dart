import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../routes/app_routes.dart';
import '../../shared_widgets/round_progress_bar.dart';
import '../../utils/constants.dart';
import '../../utils/logger.dart';
import 'search_movie_controller.dart';
import '../../models/movie_model.dart';

class MovieSearchDelegate extends SearchDelegate<MovieModel?> {
  final _searchController = Get.find<SearchMovieController>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return query.isEmpty
        ? []
        : <Widget>[
            IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            ),
          ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const SizedBox.shrink();
    }

    // always search if submitted
    return _buildMatchingSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const SizedBox.shrink();
    }

    // search-as-you-type if enabled
    return _buildMatchingSuggestions(context);
  }

  Widget _buildMatchingSuggestions(BuildContext context) {
    if (query.length < 3) {
      return const Center(
        child: Text("Type at least 3 letters to search"),
      );
    }

    _searchController.search(query);
    return Center(
      child: StreamBuilder(
          stream: _searchController.results,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.hasData) {
              final results = snapshot.data?.results ?? [];
              if (results.isEmpty) {
                return const Text('No results found');
              }
              return _buildListResults(results);
            } else {
              return const CircularProgressIndicator();
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
