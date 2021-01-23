
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.search,
    this.totalResults,
    this.response,
  });

  List<Movie> search;
  String totalResults;
  String response;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    search: json["Search"] == null ? null : List<Movie>.from(json["Search"].map((x) => Movie.fromJson(x))),
    totalResults: json["totalResults"] == null ? null : json["totalResults"],
    response: json["Response"] == null ? null : json["Response"],
  );

  Map<String, dynamic> toJson() => {
    "Search": search == null ? null : List<dynamic>.from(search.map((x) => x.toJson())),
    "totalResults": totalResults == null ? null : totalResults,
    "Response": response == null ? null : response,
  };
}

class Movie {
  Movie({
    this.title,
    this.year,
    this.imdbId,
    this.type,
    this.poster,
  });

  String title;
  String year;
  String imdbId;
  Type type;
  String poster;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    title: json["Title"] == null ? null : json["Title"],
    year: json["Year"] == null ? null : json["Year"],
    imdbId: json["imdbID"] == null ? null : json["imdbID"],
    type: json["Type"] == null ? null : typeValues.map[json["Type"]],
    poster: json["Poster"] == null ? null : json["Poster"],
  );

  Map<String, dynamic> toJson() => {
    "Title": title == null ? null : title,
    "Year": year == null ? null : year,
    "imdbID": imdbId == null ? null : imdbId,
    "Type": type == null ? null : typeValues.reverse[type],
    "Poster": poster == null ? null : poster,
  };
}

enum Type { MOVIE, GAME }

final typeValues = EnumValues({
  "game": Type.GAME,
  "movie": Type.MOVIE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}



/*
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Movie movieFromJson(String str) => Movie.fromJson(json.decode(str));

String movieToJson(Movie data) => json.encode(data.toJson());

class Movie {
  Movie({
    this.title,
    this.year,
    this.rated,
    this.released,
    this.runtime,
    this.genre,
    this.director,
    this.writer,
    this.actors,
    this.plot,
    this.language,
    this.country,
    this.awards,
    this.poster,
    this.ratings,
    this.metascore,
    this.imdbRating,
    this.imdbVotes,
    this.imdbId,
    this.type,
    this.dvd,
    this.boxOffice,
    this.production,
    this.website,
    this.response,
  });

  String title;
  String year;
  String rated;
  String released;
  String runtime;
  String genre;
  String director;
  String writer;
  String actors;
  String plot;
  String language;
  String country;
  String awards;
  String poster;
  List<Rating> ratings;
  String metascore;
  String imdbRating;
  String imdbVotes;
  String imdbId;
  String type;
  String dvd;
  String boxOffice;
  String production;
  String website;
  String response;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    title: json["Title"] == null ? null : json["Title"],
    year: json["Year"] == null ? null : json["Year"],
    rated: json["Rated"] == null ? null : json["Rated"],
    released: json["Released"] == null ? null : json["Released"],
    runtime: json["Runtime"] == null ? null : json["Runtime"],
    genre: json["Genre"] == null ? null : json["Genre"],
    director: json["Director"] == null ? null : json["Director"],
    writer: json["Writer"] == null ? null : json["Writer"],
    actors: json["Actors"] == null ? null : json["Actors"],
    plot: json["Plot"] == null ? null : json["Plot"],
    language: json["Language"] == null ? null : json["Language"],
    country: json["Country"] == null ? null : json["Country"],
    awards: json["Awards"] == null ? null : json["Awards"],
    poster: json["Poster"] == null ? null : json["Poster"],
    ratings: json["Ratings"] == null ? null : List<Rating>.from(json["Ratings"].map((x) => Rating.fromJson(x))),
    metascore: json["Metascore"] == null ? null : json["Metascore"],
    imdbRating: json["imdbRating"] == null ? null : json["imdbRating"],
    imdbVotes: json["imdbVotes"] == null ? null : json["imdbVotes"],
    imdbId: json["imdbID"] == null ? null : json["imdbID"],
    type: json["Type"] == null ? null : json["Type"],
    dvd: json["DVD"] == null ? null : json["DVD"],
    boxOffice: json["BoxOffice"] == null ? null : json["BoxOffice"],
    production: json["Production"] == null ? null : json["Production"],
    website: json["Website"] == null ? null : json["Website"],
    response: json["Response"] == null ? null : json["Response"],
  );

  Map<String, dynamic> toJson() => {
    "Title": title == null ? null : title,
    "Year": year == null ? null : year,
    "Rated": rated == null ? null : rated,
    "Released": released == null ? null : released,
    "Runtime": runtime == null ? null : runtime,
    "Genre": genre == null ? null : genre,
    "Director": director == null ? null : director,
    "Writer": writer == null ? null : writer,
    "Actors": actors == null ? null : actors,
    "Plot": plot == null ? null : plot,
    "Language": language == null ? null : language,
    "Country": country == null ? null : country,
    "Awards": awards == null ? null : awards,
    "Poster": poster == null ? null : poster,
    "Ratings": ratings == null ? null : List<dynamic>.from(ratings.map((x) => x.toJson())),
    "Metascore": metascore == null ? null : metascore,
    "imdbRating": imdbRating == null ? null : imdbRating,
    "imdbVotes": imdbVotes == null ? null : imdbVotes,
    "imdbID": imdbId == null ? null : imdbId,
    "Type": type == null ? null : type,
    "DVD": dvd == null ? null : dvd,
    "BoxOffice": boxOffice == null ? null : boxOffice,
    "Production": production == null ? null : production,
    "Website": website == null ? null : website,
    "Response": response == null ? null : response,
  };

  @override
  String toString() {
    return 'Movie{title: $title, year: $year, rated: $rated, released: $released, runtime: $runtime, genre: $genre, director: $director, writer: $writer, actors: $actors, plot: $plot, language: $language, country: $country, awards: $awards, poster: $poster, ratings: $ratings, metascore: $metascore, imdbRating: $imdbRating, imdbVotes: $imdbVotes, imdbId: $imdbId, type: $type, dvd: $dvd, boxOffice: $boxOffice, production: $production, website: $website, response: $response}';
  }
}

class Rating {
  Rating({
    this.source,
    this.value,
  });

  String source;
  String value;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    source: json["Source"] == null ? null : json["Source"],
    value: json["Value"] == null ? null : json["Value"],
  );

  Map<String, dynamic> toJson() => {
    "Source": source == null ? null : source,
    "Value": value == null ? null : value,
  };

  @override
  String toString() {
    return 'Rating{source: $source, value: $value}';
  }
}
*/
