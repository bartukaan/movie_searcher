import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/repositories/movie_repository.dart';

import '../../locator.dart';

part 'movie_search_event.dart';

part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final MovieRepository movieRepository = getIt<MovieRepository>();

  MovieSearchBloc() : super(MovieSearchInitialState());

  @override
  MovieSearchState get initialState => MovieSearchInitialState();

  @override
  Stream<MovieSearchState> mapEventToState(MovieSearchEvent event) async* {
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
