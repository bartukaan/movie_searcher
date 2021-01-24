import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:movie_app/blocs/movie/movie_search_bloc.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/favorite_movie_list.dart';
import 'package:movie_app/screens/movie_list_bloc_screen.dart';

import 'appbar_search_screen.dart';

class MainSearchScreen extends StatefulWidget {
  static final List<Movie> favoriteMovies = [];

  @override
  _MainSearchScreenState createState() => _MainSearchScreenState();
}

class _MainSearchScreenState extends State<MainSearchScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _textController;
  String _movieName;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            "Favorite movies",
            style: TextStyle(color: Colors.white),
          ),
        ),
        //Text("Search Movie APP"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: AppBarSearchScreen(
                  movieBloc: BlocProvider.of<MovieSearchBloc>(context)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 100, child: _searchBarWidget()),
          ),
          MovieListBloc(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Widget _searchBarWidget() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
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
                        .minLength(2, "Please type a movie name")
                        .build(),
                    onSaved: (text) {
                      _movieName = text;
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
                      hintText: 'Start typing a movie name...',
                      hintStyle: TextStyle(
                        color: Colors.white54,
                        fontFamily: 'OpenSans',
                      ),
                      labelText: "Movie name",
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
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    // ignore: close_sinks
                    MovieSearchBloc movieBloc =
                        BlocProvider.of<MovieSearchBloc>(context);
                    movieBloc.add(SearchMovieEvent(movieName: _movieName));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
