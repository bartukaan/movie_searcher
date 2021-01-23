import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/movie/movie_bloc.dart';
import 'package:movie_app/screens/favorite_movie_list.dart';

import 'movie_search.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Movie APP"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: MovieSearch(BlocProvider.of<MovieBloc>(context)),
            ),
          )
        ],
      ),
      body: Container(
        child: Center(
          child: FlatButton.icon(
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              Navigator.of(context).push( MaterialPageRoute(
                  builder: (BuildContext context) => FavoriteMovieList()));
            },
            icon: Icon(Icons.movie_outlined),
            label: Text("My Favorite Movies"),
          ),
        ),
      ),
    );
  }
}
