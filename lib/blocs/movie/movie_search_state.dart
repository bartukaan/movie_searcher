part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();
}

class MovieSearchInitialState extends MovieSearchState {
  @override
  List<Object> get props => [];
}

class MovieSearchingState extends MovieSearchState {
  @override
  List<Object> get props => [];
}

class MovieSearchSuccessState extends MovieSearchState {
  final List<Movie> movieList;

  MovieSearchSuccessState({@required this.movieList});

  @override
  List<Object> get props => [this.movieList];
}

class MovieSearchErrorState extends MovieSearchState {
  final errorText;

  MovieSearchErrorState({@required this.errorText});

  @override
  List<Object> get props => [this.errorText];
}

/*class AddFavoriteSuccessState extends MovieSearchState {
  final Movie movie;

  AddFavoriteSuccessState({@required this.movie});

  @override
  List<Object> get props => [this.movie];
}

class AddFavoriteErrorState extends MovieSearchState {
  final errorText;

  AddFavoriteErrorState({@required this.errorText});

  @override
  List<Object> get props => [this.errorText];
}

class RemoveFavoriteSuccessState extends MovieSearchState {
  final Movie movie;

  RemoveFavoriteSuccessState({@required this.movie});

  @override
  List<Object> get props => [this.movie];
}

class RemoveFavoriteErrorState extends MovieSearchState {
  // final Movie movie;
  final int movieIndex;

  RemoveFavoriteErrorState({@required this.movieIndex});

  @override
  List<Object> get props => [this.movieIndex];
}*/
