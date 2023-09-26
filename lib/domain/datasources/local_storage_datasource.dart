import 'package:moviepedia/domain/entities/movie.dart';

abstract class LocalStorageDatasoruce {
  Future<void> toggleFavourite(Movie movie);
  Future<bool> isMovieFavourite(int movieId);
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
