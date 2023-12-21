import 'package:flutter/material.dart';

import '../../shared_widgets/heading_section.dart';
import '../../modules/popular_movie/popular_movie_page.dart';
import '../../modules/upcoming_movie/upcoming_movie_page.dart';
import '../../modules/nowplaying_movie/nowplaying_movie_page.dart';
import '../../modules/toprated_movie/toprated_movie_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TMDB'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.view_list_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeadingSection(
                headingName: 'Popular Movies',
                onSeeAllPressed: () {

                },
              ),
              const PopularMoviePage(),
              HeadingSection(
                headingName: 'Upcoming Movies',
                onSeeAllPressed: () {},
              ),
              const UpcomingMoviePage(),
              HeadingSection(
                headingName: 'Now Playing Movies',
                onSeeAllPressed: () {},
              ),
              const NowPlayingMoviePage(),
              HeadingSection(
                headingName: 'Top Rated Movies',
                onSeeAllPressed: () {},
              ),
              const TopRatedMoviePage(),
            ],
          ),
        ),
      ),
    );
  }
}
