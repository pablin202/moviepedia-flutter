import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/domain/entities/movie.dart';
import 'package:moviepedia/domain/repositories/favourites_repository.dart';
import 'package:moviepedia/presentation/providers/favourites/local_storage_provider.dart';

final favouriteMoviesProvider =
    StateNotifierProvider<FavouriteMoviesNotifier, Map<int, Movie>>((ref) {
  final repository = ref.watch(favouritesRepositoryProvider);

  return FavouriteMoviesNotifier(favouritesRepository: repository);
});

class FavouriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final FavouritesRepository favouritesRepository;

  FavouriteMoviesNotifier({required this.favouritesRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies =
        await favouritesRepository.loadMovies(limit: 20, offset: page * 20);
    page++;

    final tmpMovies = <int, Movie>{};

    for (final movie in movies) {
      tmpMovies[movie.id] = movie;
    }
    state = {...state, ...tmpMovies};

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await favouritesRepository.toggleFavourite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
