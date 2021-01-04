import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/keys.dart';
import 'package:movies_app/models/movie_popular_response.dart';
import 'package:intl/intl.dart';

class MovieProviders {
  var pageRelease = 0;
  var hasNextData = true;
  final moviePopularEndpoint = "movie/popular";
  final streamMoviePopular = StreamController();
  final List<Results> results = List();


  getMovieRelease() async {
    pageRelease++;
    final response = await http.get("$baseUrl$moviePopularEndpoint?page=$pageRelease&api_key=$apiKey&language=${Intl.defaultLocale.substring(0,2)}");
    final json = jsonDecode(response.body);
    final moviePopularResponse = MoviePopularResponse.fromJson(json);
    hasNextData = pageRelease < moviePopularResponse.totalPages;
    results.addAll(moviePopularResponse.results);

    streamMoviePopular.sink.add(results);
  }

  close() {
    streamMoviePopular.close();
  }
}