import 'package:flutter/material.dart';
import 'package:movies_app/keys.dart';
import 'package:movies_app/models/search_movie_result.dart';
import 'package:movies_app/pages/movie_detail.dart';
import 'package:movies_app/providers/search_movie_provider.dart';

class SearchMovie extends SearchDelegate {

  final _searchMovieProvider = SearchMovieProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    final actions = List<Widget>();

    actions.add(
      IconButton(icon: Icon(Icons.search), onPressed: () {
        showResults(context);
      })
    );

    return actions;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length > 3) {
      return FutureBuilder(
        future: _searchMovieProvider.queryMovies(query),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Ocurrió un error");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Buscando...");
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final List<Results> data = snapshot.data.results;

              return ListView.separated(
                  itemBuilder: (context, index) {
                    final indexData = data[index];

                    return ListTile(
                      onTap: () {
                        final Map<String, String> args = {
                          "title": indexData.title,
                          "poster": "$basePosterUrl${indexData.posterPath}",
                          "id": indexData.id.toString()
                        };

                        Navigator.pushNamed(context, MovieDetail.ROUTE, arguments: args);
                      },
                      leading: Hero(
                        tag: "${indexData.title}${indexData.id}",
                        child: FadeInImage.assetNetwork(
                            placeholder: "images/movie_roll.png",
                            image: "$basePosterUrl${indexData.posterPath}"
                        ),
                      ),
                      title: Text(indexData.title),
                      subtitle: Text(indexData.overview, overflow: TextOverflow.fade,),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () {

                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: data.length
              );
            } else {
              return Text("No se encontraron resultados");
            }
          } else {
            return Container();
          }
        }
      );
    } else {
      return Container(
        child: Center(
          child: Text("Escriba al menos 3 caracteres"),
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 3 ) {
      return FutureBuilder(
        future: _searchMovieProvider.queryMovies(query),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Ocurrió un error");
          }

          if (snapshot.hasData) {
            final List<Results> data = snapshot.data.results;
            final suggestions = List<Widget>();

            final size = (data.length > 3) ? 3 : data.length;

            for (int i=0; i < size; i++) {
              final indexData = data[i];
              final widget = ListTile(
                onTap: () {
                  final Map<String, String> args = {
                    "title": indexData.title,
                    "poster": "$basePosterUrl${indexData.posterPath}",
                    "id": indexData.id.toString()
                  };

                  Navigator.pushNamed(context, MovieDetail.ROUTE, arguments: args);
                },
                leading: Hero(
                  tag: "${indexData.title}${indexData.id}",
                  child: FadeInImage.assetNetwork(
                      placeholder: "images/movie_roll.png",
                      image: "$basePosterUrl${indexData.posterPath}"
                  ),
                ),
                title: Text(indexData.title),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {},
                ),
              );

              suggestions.add(widget);
            }

            return ListView(
              children: suggestions,
            );
          } else {
            return Text("Buscando...");
          }
        }
      );
    } else {
      return Container();
    }
  }

}