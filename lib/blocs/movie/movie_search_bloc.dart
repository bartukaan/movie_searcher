import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/repositories/movie_repository.dart';

import '../../locator.dart';

part 'movie_search_event.dart';

part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository = getIt<MovieRepository>();

  MovieSearchBloc() : super(MovieInitialState());

  @override
  MovieState get initialState => MovieInitialState();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is SearchMovieEvent) {
      yield MovieSearchingState();
      try {
        final List<Movie> movieList =
            await movieRepository.getMovies(event.movieName);
        yield MovieSearchSuccessState(movieList: movieList);
      } catch (e) {
        yield MovieSearchErrorState(errorText: e.toString());
      }
    }
  }
}
