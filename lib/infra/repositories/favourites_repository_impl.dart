import 'package:moviepedia/domain/datasources/local_storage_datasource.dart';
import 'package:moviepedia/domain/entities/movie.dart';
import 'package:moviepedia/domain/repositories/favourites_repository.dart';

class FavouritesRepositoryImpl extends FavouritesRepository {
  final LocalStorageDatasoruce datasource;
  FavouritesRepositoryImpl(this.datasource);

  @override
  Future<bool> isMovieFavourite(int movieId) {
    return datasource.isMovieFavourite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavourite(Movie movie) {
    return datasource.toggleFavourite(movie);
  }
}
