import 'package:flutter/material.dart';
import 'package:movies_app/providers/toprated_movie_provider.dart';
import 'package:movies_app/widgets/toprated_movie_preview.dart';

class TopRatedMovies extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StateTopRatedMovies();
}

class StateTopRatedMovies extends State<TopRatedMovies> {
  final topRateMovieProvider = TopRatedMovieProvider();

  @override
  void initState() {
    super.initState();
    topRateMovieProvider.getTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: topRateMovieProvider.streamTopRatedMovie.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Ocurrió un error al solicitar los datos"),
          );
        }

        if (snapshot.hasData) {
          final data = snapshot.data;
          final hasNextData = topRateMovieProvider.hasNextData;
          //int dataSize = (hasNextData) ? data.length + 1 : data.length;
          int dataSize;
          if (hasNextData) {
            dataSize = data.length + 1;
          } else {
            dataSize = data.length;
          }
          return Container(
              height: 400,
              child: ListView.builder(
                itemCount: dataSize,
                itemBuilder: (context, index) {
                  if (index == data.length) {
                    topRateMovieProvider.getTopRatedMovies();
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                            child: CircularProgressIndicator()
                        )
                    );
                  } else {
                    final movie = data[index];

                    return TopRatedMoviePreview(movie);
                  }
                },
                scrollDirection: Axis.horizontal,
              )
          );
        } else {
          return Center(
            child: Column(
              children: [
                Text("Cargando peliculas..."),
                CircularProgressIndicator(value: null,)
              ],
            ),
          );
        }
      }
    );
  }

}