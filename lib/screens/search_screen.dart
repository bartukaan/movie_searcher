import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:movie_app/blocs/movie/movie_search_bloc.dart';
import 'package:movie_app/screens/favorite_movie_list.dart';

import 'movie_search.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _textController;
  var _formKey = GlobalKey<FormState>();
  String _movieName;

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
              delegate:
                  MovieSearch(movieBloc: BlocProvider.of<MovieSearchBloc>(context)),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildSearchBar()
              ),
            ),
            IconButton(
                icon: Icon(Icons.search,color: Colors.white,),
                onPressed: () {
                  _searchPressed();
                })
          ],
        ),
      ),




      /*Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildSearchBar(),
                  SizedBox(
                    height: 15,
                  ),
                  FlatButton.icon(
                      onPressed: _searchPressed,
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 45,
                      ),
                      label: Text(
                        "Search Movie",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),*/
    );
  }

  Widget _buildSearchBar() {
    return Container(
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
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _searchPressed() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      showSearch(
          context: context,
          delegate: MovieSearch(
              movieBloc: BlocProvider.of<MovieSearchBloc>(context),
              movieName: _movieName));
    }
  }
}
