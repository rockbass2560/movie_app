import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/keys.dart';
import 'package:movies_app/models/movie_detail_response.dart';

class MovieDetailProvider {
  final movieDetailEndPoint = "movie/";

  Future<MovieDetailResponse> getMovieDetail(String movieId) async {
    final response = await http.get("$baseUrl$movieDetailEndPoint$movieId?api_key=$apiKey");
    final json = jsonDecode(response.body);
    final movieDetailResponse = MovieDetailResponse.fromJson(json);

    return movieDetailResponse;
  }
}