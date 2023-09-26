import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/infra/datasources/isar_datasource.dart';
import 'package:moviepedia/infra/repositories/favourites_repository_impl.dart';

final favouritesRepositoryProvider = Provider((ref) {
  return FavouritesRepositoryImpl(IsarDataSourceImpl());
});
