import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/movie/movie_bloc.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieSearch extends SearchDelegate<String> {
  final List<Movie> favoriteMovies = [];
  final recentSearchingMovies = ["Matrix", "Harry Potter", "Avengers"];



  final Bloc<MovieEvent, MovieState> movieBloc;

  MovieSearch(this.movieBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = "")];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // ignore: close_sinks
  //  final _movieBloc = BlocProvider.of<MovieBloc>(context);
    movieBloc.add(SearchMovieEvent(movieName: query));
  return BlocBuilder(
      cubit: movieBloc,
      builder: (context, state) {
        debugPrint("State: $state");
        if (state is MovieInitialState) {
          return Center(child: Text("Initial"));
        }
        if (state is MovieSearchingState) {
          return Center(child: Text("Loading"));
        }
        if (state is MovieSearchErrorState) {
          print("Error:"+state.errorText);
          return Container(child: Text(state.errorText),);
        }
        if (state is MovieSearchSuccessState) {
          //var movieTitle = state.movie.title;
          List<Movie> movieList = state.movieList;
      /*    for (int i = 0; i <= movieList.length; i++) {
        //    debugPrint(    "Movie Screen => Movie Loaded " + movieList[i].toString());
          }*/
          return _buildMovieList(movieList);
        }
        else {
            return Container();
        }
      }



        );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recentSearchingMovies : recentSearchingMovies;

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.movie_outlined),
        title: Text(suggestionList[index]),
        onTap: () => showResults(context),
      ),
      itemCount: suggestionList.length,
    );
  }

  Widget _buildMovieList(List<Movie> movieList) {
    return  GridView.builder(
      itemCount: movieList.length,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.orange, width: 10),
                //borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.red,
                    offset: new Offset(10.0, 5.0),
                    blurRadius: 20.0,
                  )
                ],
                shape: BoxShape.rectangle,
                color: Colors.blue[100 * ((index + 1) % 8)],
                gradient: LinearGradient(
                    colors: [Colors.yellow, Colors.red],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                image: DecorationImage(
                    image: NetworkImage(movieList[index].poster),
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter)),
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "${movieList[index].title}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),

          onTap: () => debugPrint("Merhaba flutter $index tıklanıldı"),
          onDoubleTap: () => debugPrint("Merhaba flutter $index çift tıklanıldı"),
          onLongPress: () => debugPrint("Merhaba flutter $index uzun basıldı"),
          onHorizontalDragStart: (e) => debugPrint("Merhaba flutter $index uzun basıldı $e"),
        );
      },
    );
  }
}

