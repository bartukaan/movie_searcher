part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}
class MovieLoadingState extends MovieEvent{
  @override
  List<Object> get props => [];
}
class MovieLoadedState extends MovieEvent{
  final Movie movie;

  MovieLoadedState({@required this.movie});

  @override
  List<Object> get props => [this.movie];
}

class MovieErrorState extends MovieEvent{
  @override
  List<Object> get props => throw UnimplementedError();
}