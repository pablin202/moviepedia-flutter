import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviepedia/presentation/providers/movies/movies_providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(popularProvider).isEmpty;
  final step3 = ref.watch(topRatedProvider).isEmpty;
  final step4 = ref.watch(upcomingProvider).isEmpty;
  return (step1 || step2 || step3 || step4);
});
