part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();
}

class SearchMovieEvent extends MovieSearchEvent {
  final String movieName;

  SearchMovieEvent({@required this.movieName});

  @override
  List<Object> get props => [this.movieName];
}
