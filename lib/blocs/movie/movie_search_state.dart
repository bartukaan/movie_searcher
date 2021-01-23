part of 'movie_search_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitialState extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieSearchingState extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieSearchSuccessState extends MovieState {
  final List<Movie> movieList;

  MovieSearchSuccessState({@required this.movieList});

  @override
  List<Object> get props => [this.movieList];
}

class MovieSearchErrorState extends MovieState {
  final errorText;

  MovieSearchErrorState({@required this.errorText});

  @override
  List<Object> get props => [this.errorText];
}

class AddFavoriteSuccessState extends MovieState {
  final Movie movie;

  AddFavoriteSuccessState({@required this.movie});

  @override
  List<Object> get props => [this.movie];
}

class AddFavoriteErrorState extends MovieState {
  final errorText;

  AddFavoriteErrorState({@required this.errorText});

  @override
  List<Object> get props => [this.errorText];
}

class RemoveFavoriteSuccessState extends MovieState {
  final Movie movie;

  RemoveFavoriteSuccessState({@required this.movie});

  @override
  List<Object> get props => [this.movie];
}

class RemoveFavoriteErrorState extends MovieState {
  // final Movie movie;
  final int movieIndex;

  RemoveFavoriteErrorState({@required this.movieIndex});

  @override
  List<Object> get props => [this.movieIndex];
}
