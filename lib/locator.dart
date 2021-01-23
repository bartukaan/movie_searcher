import 'package:get_it/get_it.dart';
import 'package:movie_app/repositories/movie_repository.dart';
import 'package:movie_app/services/movie_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => MovieDataService());
  getIt.registerLazySingleton(() => MovieRepository());
}
