import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:movie_app/models/movie_model.dart';

import 'movie_base.dart';

class MovieDataService implements MovieBase {

  static const baseUrl = "http://www.omdbapi.com/?t=";
  final http.Client httpClient = http.Client();

  @override
  Future<Movie> getMovie(String movieName) async {
    movieName = "Matrix";
    final response = await httpClient.get(baseUrl + movieName);

    if(response.statusCode != 200){
      throw Exception("Exception Data getirilemedi");
    }
    final responseJSON = jsonDecode(response.body);
    debugPrint(responseJSON.toString());
    return Movie.fromJson(responseJSON);



  }

  @override
  Future<List<Movie>> getMovies(String movieName) {

  }

}