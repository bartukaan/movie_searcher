import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:movie_app/blocs/movie/movie_search_bloc.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/favorite_movie_list.dart';
import 'package:movie_app/widgets/movie_list_widget.dart';

import 'appbar_search_screen.dart';

class MainSearchScreen extends StatefulWidget {
  static final List<Movie> favoriteMovies = [];

  @override
  _MainSearchScreenState createState() => _MainSearchScreenState();
}

class _MainSearchScreenState extends State<MainSearchScreen> {
  Bloc<MovieSearchEvent, MovieSearchState> movieBloc;

  TextEditingController _textController;
//  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //String _movieName;
/*  final GlobalKey<FormState> _formKey=
  new GlobalKey<FormState>(debugLabel: '_loginFormKey');*/

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
              delegate: AppBarSearchScreen(
                  movieBloc: BlocProvider.of<MovieSearchBloc>(context)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [

           _searchBarWidget(movieBloc),

          Expanded(
            child: BlocListener<MovieSearchBloc,MovieSearchState>(
            //  cubit: movieBloc,
              listener: (context, state) {
                debugPrint("State: $state");
               if (state is MovieInitialState) {
                 // return _searchBarWidget(movieBloc);
                  return Center(child: Text("Search Movie",style: TextStyle(fontSize: 25,color: Colors.white),),);
                }else if (state is MovieSearchingState) {

                 return Container(child: Center(child: CircularProgressIndicator(),));
               /*   return Column(
                    children: [
                      _searchBarWidget(movieBloc),
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    ],
                  );*/
                } else  if (state is MovieSearchErrorState) {
                  debugPrint("Error:" + state.errorText);
                  if (state.errorText.toString().contains("null")) {
                    return Container(
                      child: Center(child: Text("Please Enter a Movie Name")),
                    );
                  }
                }else  if (state is MovieSearchSuccessState) {
                  List<Movie> movieList = state.movieList;
                  return Container(child: Expanded(child: Column(children: [Container(child: _searchBarWidget(movieBloc)),MovieList(movieList: movieList)],)));
                 // return MovieList(movieList: movieList);
                } else {
                  //return _searchBarWidget(movieBloc);
                  return Container(child: Center(child: Text("Search Movie",style: TextStyle(fontSize: 25,color: Colors.white),),));
                }
              },
            ),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _textController.dispose();
    movieBloc.close();
    super.dispose();
  }

  Widget _searchBarWidget(MovieSearchBloc movieBloc) {
     GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                /*    onSaved: (text) {
                      _movieName = text;
                      //   movieBloc.add(SearchMovieEvent(movieName: _movieName));
                    },*/
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
                    movieBloc.add(SearchMovieEvent(movieName: _textController.text));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
