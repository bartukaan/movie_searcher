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
  final Movie movie;

  MovieLoadedState({@required this.movie});

  @override
  List<Object> get props => [this.movie];
}

class MovieErrorState extends MovieState{
  final errorText;

  MovieErrorState({@required this.errorText});

  @override
  List<Object> get props => [this.errorText];
}