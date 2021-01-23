import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/movie_search.dart';
import 'package:movie_app/screens/search_screen.dart';

class FavoriteMovieList extends StatefulWidget {
  @override
  _FavoriteMovieListState createState() => _FavoriteMovieListState();
}

class _FavoriteMovieListState extends State<FavoriteMovieList> {
  List<Movie> favoriteMovieList;

  @override
  void initState() {
    //favoriteMovieList = MovieSearch.favoriteMovies;
    favoriteMovieList = SearchScreen.favoriteMovies;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favorite Movies"),
      ),
      body: _favoriteMovieList(context),
    );
  }

  _favoriteMovieList(BuildContext context) {
    return ListView.builder(
        itemCount: favoriteMovieList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.movie),
                SizedBox(width: 15),
                Text(favoriteMovieList[index].title),
              ],
            ),
            //leading:,
            //subtitle: ,
            trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _showAlertDialog(context, index)),
          );
        });
  }

  _showAlertDialog(BuildContext context, int index) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        setState(() {
          favoriteMovieList.remove(favoriteMovieList[index]);
          Navigator.of(context).pop();
        });
      },
    );

    Widget cancelButton = FlatButton(
      child: Text("CANCEL"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("ARE YOU SURE?"),
      content: Text("Movie removing your favorite list. "),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
