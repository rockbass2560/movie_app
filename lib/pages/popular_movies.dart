import 'package:flutter/material.dart';
import 'package:movies_app/providers/movie_providers.dart';
import 'package:movies_app/widgets/movie_preview.dart';

class PopularMovies extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => StatePopularMovie();

}

class StatePopularMovie extends State<PopularMovies> {
  final movieProvider = MovieProviders();

  @override
  void initState() {
    super.initState();

    movieProvider.getMovieRelease();
  }

  @override
  void dispose() {
    super.dispose();
    movieProvider.close();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: movieProvider.streamMoviePopular.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Ocurrió un error al solicitar los datos"),
          );
        }

        if (snapshot.hasData) {
          final data = snapshot.data;
          final hasNextData = movieProvider.hasNextData;
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
                    movieProvider.getMovieRelease();
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Center(
                          child: CircularProgressIndicator()
                      )
                    );
                  } else {
                    final movie = data[index];

                    return MoviePreview(movie);
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