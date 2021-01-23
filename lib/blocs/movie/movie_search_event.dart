part of 'movie_search_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class SearchMovieEvent extends MovieEvent {
  final String movieName;

  SearchMovieEvent({@required this.movieName});

  @override
  List<Object> get props => [this.movieName];
}
