import '../entities/movie.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getNewPlaying({int page = 1});
}
