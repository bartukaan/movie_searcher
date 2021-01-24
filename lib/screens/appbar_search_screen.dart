import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/movie/movie_search_bloc.dart';
import 'package:movie_app/models/movie_model.dart';

class AppBarSearchScreen extends SearchDelegate<String> {
  static final List<Movie> favoriteMovies = [];
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
    return BlocBuilder(
        cubit: movieBloc,
        builder: (context, state) {
          debugPrint("State: $state");
          if (state is MovieInitialState) {
            return Center(child: Text("Initial"));
          }
          if (state is MovieSearchingState) {
            return Center(child: CircularProgressIndicator());
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

            return _buildMovieList(movieList);
          } else {
            return Container();
          }
        });
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
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              borderRadius: BorderRadius.circular(16),
              //elevation: 1,
              color: Colors.grey.shade300,

              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          isAddedList
                              ? FlatButton.icon(
                                  onPressed: () {
                                    favoriteMovies.remove(movieList[index]);
                                    setState(() {
                                      isAddedList = !isAddedList;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  label: Text("Added to Favorites"),
                                )
                              : FlatButton.icon(
                                  onPressed: () {
                                    favoriteMovies.add(movieList[index]);
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
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            movieList[index].title,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(movieList[index].year,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold))),
                      ),
                      /*  Card(
                        color: Colors.transparent,*/
                      Container(
                        width: 100, //MediaQuery.of(context).size.width,
                        height: 250, //MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: NetworkImage(movieList[index].poster),
                                fit: BoxFit.fitHeight)),
                        /*child: Column(
                          children: [
                            Text("TYPE:" + movieList[index].type.toString()),
                            Text("IMDB ID: ${movieList[index].imdbId}"),
                          ],
                        ),*/
                      ),
                      // ),
                    ],
                  ),
                );
              }),
            ),
          ),
          onTap: () => debugPrint("Movie $index tıklanıldı"),
          onDoubleTap: () => debugPrint("Movie $index çift tıklanıldı"),
          onLongPress: () => debugPrint("Movie $index uzun basıldı"),
          onHorizontalDragStart: (e) =>
              debugPrint("Movie $index uzun basıldı $e"),
        );
      },
    );
  }
}
