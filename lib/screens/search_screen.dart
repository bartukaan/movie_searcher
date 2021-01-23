import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:movie_app/blocs/movie/movie_search_bloc.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/favorite_movie_list.dart';
import 'package:movie_app/widgets/movie_list_widget.dart';

import 'movie_search.dart';

class SearchScreen extends StatefulWidget {
  static final List<Movie> favoriteMovies = [];

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  Bloc<MovieEvent, MovieState> movieBloc;

//  static final List<Movie> favoriteMovies = [];

  TextEditingController _textController;
  var _formKey = GlobalKey<FormState>();
  String _movieName;

  //_SearchScreenState({this.movieBloc});

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
     movieBloc = BlocProvider.of<MovieSearchBloc>(context);
    return Scaffold(
      backgroundColor: Color(0xFF00385d),
      appBar: AppBar(
        title: FlatButton.icon(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => FavoriteMovieList()));
          },
          icon: Icon(
            Icons.movie_outlined,
            color: Colors.white,
          ),
          label: Text(
            "Go to My Favorite Movies",
            style: TextStyle(color: Colors.white),
          ),
        ),
        //Text("Search Movie APP"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: MovieSearch(
                  movieBloc: BlocProvider.of<MovieSearchBloc>(context)),
            ),
          ),
        ],
      ),
      body: BlocBuilder(
        cubit: movieBloc,
        builder: (context, state) {
          debugPrint("State: $state");
          if (state is MovieInitialState) {
            //return Center(child: Text("Initial"));

            return _searchBarWidget(movieBloc);
          }

          if (state is MovieSearchingState) {
            return Column(
              children: [
                _searchBarWidget(movieBloc),
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
            return MovieList(movieList: movieList);
            //return _buildMovieList(movieList);
          } else {
            return _searchBarWidget(movieBloc);
          }
        },
      ),
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            borderRadius: BorderRadius.circular(16),
            //elevation: 1,
            color: Colors.grey.shade300,
            child: Container(
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
                                SearchScreen.favoriteMovies
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
                              label: Text("Added to Favorites"),
                            )
                          : FlatButton.icon(
                              onPressed: () {
                                SearchScreen.favoriteMovies
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
                                fontSize: 14, fontWeight: FontWeight.bold))),
                  ),
                  Container(
                    width: 100,
                    height: 250,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    movieBloc.close();
    super.dispose();
  }

  Widget _searchBarWidget(MovieSearchBloc movieBloc) {
    return Container(
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _textController,
                    validator: ValidationBuilder()
                        .required("Movie name is required.")
                        .minLength(2, "Please enter a movie name")
                        .build(),
                    onSaved: (text) {
                      _movieName = text;
                      //   movieBloc.add(SearchMovieEvent(movieName: _movieName));
                    },
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.search,
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.movie_outlined,
                        color: Colors.white,
                      ),
                      hintText: 'Enter a movie name',
                      hintStyle: TextStyle(
                        color: Colors.white54,
                        fontFamily: 'OpenSans',
                      ),
                      labelText: "Movie Name",
                      labelStyle: TextStyle(
                        color: Colors.white54,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  // _searchPressed();
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    movieBloc.add(SearchMovieEvent(movieName: _movieName));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
