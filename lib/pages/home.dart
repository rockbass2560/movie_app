import 'package:flutter/material.dart';
import 'package:movies_app/pages/popular_movies.dart';
import 'package:movies_app/pages/toprated_movies.dart';
import 'package:movies_app/providers/movie_providers.dart';
import 'package:movies_app/widgets/search_movie.dart';

class Home extends StatelessWidget {
  static const ROUTE = "/";

  final titleStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.movie),
          title: Text("Peliculas"),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: SearchMovie());
                }
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 8, top: 8),
            child: Column(
              children: [
                Text("Lanzamientos", style: titleStyle,),
                PopularMovies(),
                Text("Mejor Calificadas", style: titleStyle,),
                TopRatedMovies()
              ],
            ),
          ),
        )
      ),
    );
  }

}