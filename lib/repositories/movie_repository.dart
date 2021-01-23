import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/movie_service.dart';

import '../locator.dart';

class MovieRepository {
  MovieDataService movieDataService = getIt<MovieDataService>();

  Future<List<Movie>> getMovies(String movieName) async {
    return await movieDataService.getMovies(movieName);
  }
}
