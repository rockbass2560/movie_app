import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/keys.dart';
import 'package:movies_app/models/toprated_movie_response.dart';
import 'package:movies_app/pages/movie_detail.dart';

class TopRatedMoviePreview extends StatelessWidget {
  final TopRatedResults movie;
  final previewStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final dateStyle = TextStyle(fontSize: 18);
  final dateFormat = DateFormat.yMMMd();

  TopRatedMoviePreview(movie) : this.movie = movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final Map<String, String> args = {
          "poster": "$basePosterUrl${movie.posterPath}",
          "title": movie.title,
          "id": movie.id.toString()
        };

        Navigator.pushNamed(context, MovieDetail.ROUTE, arguments: args);
      },
      child: Card(
          elevation: 3,
          child: Container(
              height: 400,
              width: 300,
              child: Column(children: [
                Hero(
                    tag: "${movie.title}${movie.id}",
                    child: FadeInImage.assetNetwork(
                      width: 300,
                      height: 300,
                      fit: BoxFit.contain,
                      placeholder: "images/movie_roll.png",
                      image: "$basePosterUrl${movie.posterPath}",
                    )
                ),
                Column(
                  children: [
                    Text(movie.title, style: previewStyle, textAlign: TextAlign.center,),
                    Text(dateFormat.format(DateTime.parse(movie.releaseDate)), style: dateStyle, textAlign: TextAlign.center),
                  ],
                )
              ]
              )
          )
      ),
    );
  }

}