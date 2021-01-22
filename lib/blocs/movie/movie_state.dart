part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitialState extends MovieState {
  @override
  List<Object> get props => [];
}
class MovieLoadingState extends MovieState{
  @override
  List<Object> get props => [];
}
class MovieLoadedState extends MovieState{
  final List<Movie> movieList;

  MovieLoadedState({@required this.movieList});

  @override
  List<Object> get props => [this.movieList];
}

class MovieErrorState extends MovieState{
  final errorText;

  MovieErrorState({@required this.errorText});

  @override
  List<Object> get props => [this.errorText];
}