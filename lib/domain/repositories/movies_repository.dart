import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNewPlaying({int page = 1});
}
