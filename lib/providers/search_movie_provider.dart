import 'dart:convert';

import 'package:movies_app/keys.dart';
import 'package:movies_app/models/search_movie_result.dart';
import 'package:http/http.dart' as http;

class SearchMovieProvider {

  final _searchMovieEndPoint = "search/movie";

  Future<SearchMovieResult> queryMovies(String query) async {
    final queryUrl = "$baseUrl$_searchMovieEndPoint?query=$query&api_key=$apiKey";
    final result = await http.get(queryUrl);
    final json = jsonDecode(result.body);
    final searchMovieResult = SearchMovieResult.fromJson(json);

    return searchMovieResult;
  }

}