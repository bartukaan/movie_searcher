part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class SearchMovieEvent extends MovieEvent {
  final String movieName;

  SearchMovieEvent({@required this.movieName});

  @override
  List<Object> get props => [this.movieName];
}

class AddFavoriteMovieEvent extends MovieEvent{
  final List<Movie> favoriteMovieList;

  AddFavoriteMovieEvent({@required this.favoriteMovieList});

  @override
  List<Object> get props => [this.favoriteMovieList];

}

class RemoteFavoriteMovieEvent extends MovieEvent{
  final List<Movie> movieList;

  RemoteFavoriteMovieEvent({@required this.movieList});

  @override
  List<Object> get props => [this.movieList];

}