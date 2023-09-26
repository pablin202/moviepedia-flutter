import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moviepedia/config/util/extensions.dart';
import 'package:moviepedia/presentation/providers/favourites/favourite_movie_provider.dart';
import 'package:moviepedia/presentation/widgets/movies/movies_masonry.dart';

class FavouritesView extends ConsumerStatefulWidget {
  const FavouritesView({super.key});

  @override
  FavouritesViewState createState() => FavouritesViewState();
}

class FavouritesViewState extends ConsumerState<FavouritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ref.read(favouriteMoviesProvider.notifier).loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favouriteMoviesProvider.notifier).loadNextPage();

    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(favouriteMoviesProvider).values.toList();

    if (movies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp,
                size: 60, color: context.colorScheme.primary),
            Text('Ohhh no!!',
                style: TextStyle(
                    fontSize: 30, color: context.colorScheme.primary)),
            const Text('No favourites movies yet...',
                style: TextStyle(fontSize: 20, color: Colors.black45)),
            const SizedBox(height: 20),
            FilledButton.tonal(
                onPressed: () => context.go('/home/0'),
                child: const Text('Start to search'))
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(loadNextPage: loadNextPage, movies: movies),
    );
  }
}
