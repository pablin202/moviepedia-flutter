import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/domain/entities/movie.dart';
import 'package:moviepedia/presentation/providers/movies/movies_providers.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingProvider = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingProvider.isEmpty) {
    return [];
  } else {
    return nowPlayingProvider.sublist(0, 6);
  }
});
