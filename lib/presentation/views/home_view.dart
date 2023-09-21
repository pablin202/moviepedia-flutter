import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moviepedia/presentation/providers/movies/initial_loading_provider.dart';
import 'package:moviepedia/presentation/providers/movies/movies_providers.dart';
import 'package:moviepedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:moviepedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:moviepedia/presentation/widgets/movies/movies_slideshow.dart';
import 'package:moviepedia/presentation/widgets/shared/custom_app_bar.dart';
import 'package:moviepedia/presentation/widgets/shared/full_screen_loader.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularProvider.notifier).loadNextPage();
    ref.read(topRatedProvider.notifier).loadNextPage();
    ref.read(upcomingProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final nowPlaying = ref.watch(nowPlayingMoviesProvider);
    final popular = ref.watch(popularProvider);
    final topRated = ref.watch(topRatedProvider);
    final upcoming = ref.watch(upcomingProvider);
    final slideMovies = ref.watch(moviesSlideshowProvider);

    return Visibility(
      visible: !initialLoading,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(title: CustomAppBar()),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                MoviesSlideshow(movies: slideMovies),
                MovieHorizontalListView(
                  movies: nowPlaying,
                  title: 'Cinema',
                  subTitle: DateFormat('EEEE, d MMM').format(DateTime.now()),
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListView(
                  movies: popular,
                  title: 'Popular',
                  subTitle: null,
                  loadNextPage: () {
                    ref.read(popularProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListView(
                  movies: topRated,
                  title: 'Top Rated',
                  subTitle: null,
                  loadNextPage: () {
                    ref.read(topRatedProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListView(
                  movies: upcoming,
                  title: 'Upcoming',
                  subTitle: null,
                  loadNextPage: () {
                    ref.read(upcomingProvider.notifier).loadNextPage();
                  },
                )
              ],
            );
          }, childCount: 1))
        ],
      ),
    );
  }
}
