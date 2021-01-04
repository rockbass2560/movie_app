import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/keys.dart';
import 'package:movies_app/models/movie_popular_response.dart';
import 'package:movies_app/pages/movie_detail.dart';

class MoviePreview extends StatelessWidget {
  final Results movie;
  final previewStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final dateStyle = TextStyle(fontSize: 18);
  final dateFormat = DateFormat.yMMMd();

  MoviePreview(movie) : this.movie = movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        final Map<String, String> args = {
          "poster": "$basePosterUrl${movie.posterPath}",
          "title": movie.title,
          "id": movie.id.toString()
        };

        Navigator.pushNamed(context, MovieDetail.ROUTE, arguments: args);
      },
      focusColor: Colors.blue.withOpacity(.75),
      child: Card(
          elevation: 3,
          child: Container(
              height: 400,
              width: 300,
              child: Column(children: [
                Hero(
                    tag: "${movie.title}${movie.id}",
                    child: Image.network(
                      "$basePosterUrl${movie.posterPath}",
                      height: 300,
                      width: 300,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, chunkEvent) {
                        if (chunkEvent == null) {
                          return child;
                        } else {
                          return Container(
                            height: 300,
                            width: 300,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: chunkEvent.cumulativeBytesLoaded /
                                    chunkEvent.expectedTotalBytes,
                              ),
                            ),
                          );
                        }
                      },
                    )
                ),
                Column(
                  children: [
                    Text(
                      movie.title,
                      style: previewStyle,
                      textAlign: TextAlign.center,
                    ),
                    Text(dateFormat.format(DateTime.parse(movie.releaseDate)),
                        style: dateStyle, textAlign: TextAlign.center),
                  ],
                )
              ]))),
    );
  }
}
