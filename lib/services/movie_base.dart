

import 'package:movie_app/models/movie_model.dart';

abstract class MovieBase {

 // Future<List<Movie>> getInitialMovies();

  Future<bool> getMovie(String movieName);

  Future<List<Movie>> getMovies(String movieName);


}