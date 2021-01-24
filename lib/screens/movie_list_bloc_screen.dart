import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/movie/movie_search_bloc.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/widgets/movie_list_widget.dart';

class MovieListBloc extends StatelessWidget {
  // ignore: close_sinks
  Bloc<MovieSearchEvent, MovieSearchState> movieBloc;

  @override
  Widget build(BuildContext context) {
    movieBloc = BlocProvider.of<MovieSearchBloc>(context);
    return BlocBuilder<MovieSearchBloc, MovieSearchState>(
      cubit: movieBloc,
      builder: (context, state) {
        debugPrint("State: $state");
        if (state is MovieSearchInitialState) {
          return Center(
            child: Text("Serch Movie"),
          );
        }

        if (state is MovieSearchingState) {
          return Column(
            children: [
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        }

        if (state is MovieSearchErrorState) {
          print("Error:" + state.errorText);
          if (state.errorText.toString().contains("null")) {
            return Container(
              child: Center(child: Text("Please Enter a Movie Name")),
            );
          }
        }

        if (state is MovieSearchSuccessState) {
          List<Movie> movieList = state.movieList;
          return Expanded(
              child: Container(child: MovieList(movieList: movieList)));
        } else {
          return Center(
            child: Text("Search Movie"),
          );
        }
      },
    );
  }
}
