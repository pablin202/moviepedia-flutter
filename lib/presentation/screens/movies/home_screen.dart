import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/presentation/providers/movies/movies_providers.dart';
import 'package:moviepedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:moviepedia/presentation/widgets/movies/movies_slideshow.dart';
import 'package:moviepedia/presentation/widgets/shared/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _HomeView());
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final slideMovies = ref.watch(moviesSlideshowProvider);

    return Column(
      children: [const CustomAppBar(), MoviesSlideshow(movies: slideMovies)],
    );
  }
}
