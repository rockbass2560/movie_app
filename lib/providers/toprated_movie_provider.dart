
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/keys.dart';
import 'package:movies_app/models/toprated_movie_response.dart';

class TopRatedMovieProvider {
  var _topRatedPage = 0;
  var hasNextData = true;
  final _topRatedMovieEndPoint = "movie/top_rated";
  final streamTopRatedMovie = StreamController();
  final List<TopRatedResults> _topRatedMovieResults = List();

  getTopRatedMovies() async {
    _topRatedPage++;

    final response = await http.get("$baseUrl$_topRatedMovieEndPoint?page=$_topRatedPage&api_key=$apiKey");
    final json = jsonDecode(response.body);
    final topRatedMovieResult = TopRatedMovieResult.fromJson(json);
    hasNextData = _topRatedPage < topRatedMovieResult.totalPages;

    _topRatedMovieResults.addAll(topRatedMovieResult.results);

    streamTopRatedMovie.sink.add(_topRatedMovieResults);
  }

  close() {
    streamTopRatedMovie.close();
  }
}