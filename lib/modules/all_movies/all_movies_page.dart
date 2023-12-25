import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../models/base_type.dart';
import '../../modules/all_movies/all_movies_controller.dart';
import '../../utils/logger.dart';
import 'card_item.dart';

class AllMoviesPage extends StatefulWidget {
  const AllMoviesPage({super.key});

  @override
  State<AllMoviesPage> createState() => _AllMoviesPageState();
}

class _AllMoviesPageState extends State<AllMoviesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle),
      ),
      body: _getBody,
    );
  }

  String get _getAppBarTitle {
    switch (Get.arguments) {
      case BaseType.POPULAR_MOVIE:
        return 'All Popular Movies';
      case BaseType.POPULAR_TVSHOWS:
        return 'All Popular TV Shows';
      case BaseType.TOPRATED_TVSHOWS:
        return 'All Top Rated TV Shows';
      case BaseType.TOPRATED_MOVIE:
        return 'All Top Rated Movies';
      default:
        return '';
    }
  }

  void _navigateToTop() {
    const Duration duration = Duration(milliseconds: 400);
    const Curve curve = Curves.ease;
    var scrollPosition = _scrollController.position;
    scrollPosition.animateTo(
      0,
      duration: duration,
      curve: curve,
    );
  }

  Widget get _getBody => SafeArea(
        child: GetBuilder<AllMoviesController>(
          builder: (controller) {
            if (controller.isLoading.value) {
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

            bool isLastItem = false;
            final allMovies = controller.allMovies;
            final currentPage = controller.currentPage;
            return ListView.builder(
                controller: _scrollController,
                itemCount: allMovies.length,
                itemBuilder: (context, index) {
                  isLastItem = (allMovies.length - 1) == index;

                  // verify the last item
                  if (isLastItem) {
                    return Column(
                      children: [
                        CardItem(result: allMovies[index]),
                        Obx(() {
                          return controller.isLoading.value
                              ? const CircularProgressIndicator()
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    controller.totalPages > currentPage
                                        ? TextButton(
                                            onPressed: () async {
                                              // request to next result
                                              await controller.loadMore(currentPage + 1);
                                              'update allMovies: ${allMovies.length}'.log();

                                              // trigger state to rebuild
                                              setState(() {});
                                            },
                                            child: const Text('Load More'),
                                          )
                                        : const SizedBox.shrink(),
                                    TextButton.icon(
                                      label: const Text('Go Up'),
                                      onPressed: _navigateToTop,
                                      icon: const Icon(Icons.keyboard_arrow_up),
                                    ),
                                  ],
                                );
                        }),
                      ],
                    );
                  } else {
                    return CardItem(result: allMovies[index]);
                  }
                });
          },
        ),
      );
}
