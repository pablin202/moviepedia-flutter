import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/infra/datasources/moviedb_datasource.dart';
import 'package:moviepedia/infra/repositories/movie_repository_impl.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MovieDbDatasurce());
});
