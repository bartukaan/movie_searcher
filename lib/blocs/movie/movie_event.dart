part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class FetchMovieEvent extends MovieEvent {
  final String movieName;

  FetchMovieEvent({@required this.movieName});

  @override
  List<Object> get props => throw UnimplementedError();
}