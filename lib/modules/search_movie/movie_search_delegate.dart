import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../routes/app_routes.dart';
import '../../shared_widgets/round_progress_bar.dart';
import '../../utils/constants.dart';
import 'search_movie_controller.dart';

class MovieSearchDelegate extends SearchDelegate {
  List<String> searchResults = [
    'Jame Bond',
    'Rambo',
    'Wrong Turn',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isNotEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return const Center(
        child: Text("Type at least 3 letters to search"),
      );
    }
    final searchCtr = Get.find<SearchMovieController>();
    searchCtr.search(query: query);
    return GetBuilder<SearchMovieController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.errMsg.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(controller.errMsg),
          );
        }

        final results = controller.resultSearchMovie?.results ?? [];
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
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
          },
        );
      },
    );
  }
}
