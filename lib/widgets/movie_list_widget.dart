import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/main_search_screen.dart';

class MovieList extends StatefulWidget {
  final List<Movie> movieList;

  const MovieList({Key key, this.movieList}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: widget.movieList.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2/4),

      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            borderRadius: BorderRadius.circular(16),
            //elevation: 1,
            color: Colors.grey.shade300,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      widget.movieList[index].isFavorite
                          ? FlatButton.icon(
                              onPressed: () {
                                MainSearchScreen.favoriteMovies
                                    .remove(widget.movieList[index]);
                                setState(() {
                                  widget.movieList[index].isFavorite = false;
                                });
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 20,
                              ),
                              label: Center(
                                  child: Text(
                                "Added to Favorite",
                                style: TextStyle(fontSize: 10),
                              )),
                            )
                          : FlatButton.icon(
                              onPressed: () {
                                MainSearchScreen.favoriteMovies
                                    .add(widget.movieList[index]);
                                setState(() {
                                  widget.movieList[index].isFavorite = true;
                                });
                              },
                              icon: Icon(
                                Icons.favorite,
                                size: 20,
                              ),
                              label: Text(
                                "Add Favorite",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text(
                        widget.movieList[index].title,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                        child: Text(widget.movieList[index].year,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold))),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          image: DecorationImage(
                              image: NetworkImage(widget.movieList[index].poster),
                              fit: BoxFit.cover)),
                      /*child: Column(
                          children: [
                            Text("TYPE:" + widget.movieList[index].type.toString()),
                            Text("IMDB ID: ${widget.movieList[index].imdbId}"),
                          ],
                        ),*/
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
