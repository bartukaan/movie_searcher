import 'dart:convert';

SearchResult searchFromJson(String str) => SearchResult.fromJson(json.decode(str));

String searchToJson(SearchResult data) => json.encode(data.toJson());

class SearchResult {
  SearchResult({
    this.search,
    this.totalResults,
    this.response,
  });

  List<Movie> search;
  String totalResults;
  String response;

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        search: json["Search"] == null
            ? null
            : List<Movie>.from(json["Search"].map((x) => Movie.fromJson(x))),
        totalResults:
            json["totalResults"] == null ? null : json["totalResults"],
        response: json["Response"] == null ? null : json["Response"],
      );

  Map<String, dynamic> toJson() => {
        "Search": search == null
            ? null
            : List<dynamic>.from(search.map((x) => x.toJson())),
        "totalResults": totalResults == null ? null : totalResults,
        "Response": response == null ? null : response,
      };
}

class Movie {
  Movie(
      {this.title,
      this.year,
      this.imdbId,
      this.type,
      this.poster,
      this.isFavorite = false});

  String title;
  String year;
  String imdbId;
  Type type;
  String poster;
  bool isFavorite;

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

final typeValues = EnumValues({"game": Type.GAME, "movie": Type.MOVIE});

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