import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_app/models/movie_model.dart';

import 'movie_base.dart';

class MovieDataService implements MovieBase {
  static const baseUrl =
      "http://www.omdbapi.com/?i=tt3896198&apikey=52fb3639&s=";

  final http.Client httpClient = http.Client();

  @override
  Future<List<Movie>> getMovies(String movieName) async {
    final response = await httpClient.get(baseUrl + movieName);

    if (response.statusCode != 200) {
      throw Exception("Exception Data getirilemedi");
    }
    final responseJSON = jsonDecode(response.body);
    debugPrint("Movie Service => response: " + responseJSON.toString());
    var data = responseJSON["Search"];
    debugPrint("Movie Service => responseJSON[Search]: " + data.toString());

    var movieList = data.map<Movie>((p) => Movie.fromJson(p)).toList();

    return Future.value(movieList);
  }
}
