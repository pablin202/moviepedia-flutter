import 'package:isar/isar.dart';
import 'package:moviepedia/domain/datasources/local_storage_datasource.dart';
import 'package:moviepedia/domain/entities/movie.dart';
import 'package:path_provider/path_provider.dart';

class IsarDataSourceImpl extends LocalStorageDatasoruce {
  late Future<Isar> db;

  IsarDataSourceImpl() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema],
          directory: dir.path, inspector: true);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavourite(int movieId) async {
    final isar = await db;
    final Movie? isFavouriteMovie =
        await isar.movies.filter().idEqualTo(movieId).findFirst();
    return isFavouriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;
    return isar.movies.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavourite(Movie movie) async {
    final isar = await db;
    final Movie? favouriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favouriteMovie != null) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favouriteMovie.isarId!));
      return;
    }

    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }
}
