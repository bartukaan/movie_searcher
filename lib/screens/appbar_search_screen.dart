import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/movie/movie_search_bloc.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/main_search_screen.dart';

class AppBarSearchScreen extends SearchDelegate<String> {
  final recentSearchingMovies = [
    "Matrix",
    "Lord of the Rings",
    "Star Wars",
    "Harry Potter",
    "Avengers",
    "Bourne Legacy",
    "Inception",
    "Fast and Furious",
    "Shawshank Redemption"
  ];

  final Bloc<MovieSearchEvent, MovieSearchState> movieBloc;

  AppBarSearchScreen({@required this.movieBloc});

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
    movieBloc.add(SearchMovieEvent(movieName: query));
    return BlocBuilder<MovieSearchBloc, MovieSearchState>(
      cubit: movieBloc,
      builder: (context, state) {
        debugPrint("State: $state");
        if (state is MovieSearchInitialState) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Search for movies",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ));
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
          return Center(
            child: Text(
              "Opps! something went wrong, try again...",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          );
        }

        if (state is MovieSearchSuccessState) {
          List<Movie> movieList = state.movieList;
          return Expanded(child: Container(child: _buildMovieList(movieList)));
        } else {
          return Center(
            child: Text(
              "Search Movie",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.movie_outlined),
        title: Text(recentSearchingMovies[index]),
        onTap: () {
          query = recentSearchingMovies[index];
          if (!recentSearchingMovies.contains(query)) {
            recentSearchingMovies.add(query);
          }
          showResults(context);
        },
      ),
      itemCount: recentSearchingMovies.length,
    );
  }

  Widget _buildMovieList(List<Movie> movieList) {
    bool isAddedList = false;
    return GridView.builder(
      shrinkWrap: true,
      itemCount: movieList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 2 / 4),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            borderRadius: BorderRadius.circular(16),
            //elevation: 1,
            color: Colors.grey.shade300,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        isAddedList
                            ? FlatButton.icon(
                                onPressed: () {
                                  MainSearchScreen.favoriteMovies
                                      .remove(movieList[index]);
                                  setState(() {
                                    isAddedList = !isAddedList;
                                  });
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                label: Text("Added to Favorite"),
                              )
                            : FlatButton.icon(
                                onPressed: () {
                                  MainSearchScreen.favoriteMovies
                                      .add(movieList[index]);
                                  setState(() {
                                    isAddedList = !isAddedList;
                                  });
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  size: 30,
                                ),
                                label: Text("Add Favorite"),
                              ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Center(
                        child: Text(
                          movieList[index].title,
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Center(
                          child: Text(movieList[index].year,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold))),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            image: DecorationImage(
                                image: NetworkImage(movieList[index].poster),
                                fit: BoxFit.cover)),
                        /*child: Column(
                          children: [
                            Text("TYPE:" + movieList[index].type.toString()),
                            Text("IMDB ID: ${movieList[index].imdbId}"),
                          ],
                        ),*/
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
