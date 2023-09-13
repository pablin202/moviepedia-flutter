import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infra/datasources/actor_moviedb_datasource.dart';
import '../../../infra/repositories/actor_repository_impl.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});
