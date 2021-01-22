import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/repositories/movie_repository.dart';

import '../../locator.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository = getIt<MovieRepository>();

  MovieBloc() : super(MovieInitialState());

  @override
  MovieState get initialState => MovieInitialState();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMovieEvent) {
      yield MovieLoadingState();
      try {
        final List<Movie> movie = await movieRepository.getMovies(event.movieName);
        yield MovieLoadedState(movieList: movie);
      } catch (e) {
        yield MovieErrorState(errorText: e.toString());
      }
    }
  }
}
