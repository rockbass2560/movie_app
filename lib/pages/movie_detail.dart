import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_app/models/movie_detail_response.dart';
import 'package:movies_app/providers/movie_detail_provider.dart';

class MovieDetail extends StatefulWidget {
  static const ROUTE = "/movie_detail";

  @override
  State<StatefulWidget> createState() => StateMovieDetail();

}

class StateMovieDetail extends State<MovieDetail> {

  final movieDetailProvider = MovieDetailProvider();
  final numberFormat = NumberFormat.simpleCurrency();

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args = ModalRoute.of(context).settings.arguments;
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    title: Text(args["title"]),
                    pinned: true,
                    floating: false,
                    expandedHeight: 350,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        child: Hero(
                          tag: "${args["title"]}${args["id"]}",
                          child: Image.network(
                            args["poster"],
                            fit: BoxFit.contain,
                          ),
                        )
                      ),
                    ),
                  )
                ];
              },
              body: FutureBuilder(
                future: movieDetailProvider.getMovieDetail(args["id"]),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Ocurrió un error"),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return TabBarView(
                          children: [
                            createInfoMovie(snapshot.data),
                            createOverviewMovie(snapshot.data)
                          ]
                      );
                    } else {
                      return Center(
                        child: Text("No se encontró información"),
                      );
                    }
                  }

                  return Container();
                },
              ),
            ),
            bottomNavigationBar: TabBar(
              labelColor: Colors.blue,
              tabs: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Información"),
                    Icon(Icons.info)
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Resumen"),
                    Icon(Icons.movie_filter)
                  ],
                )
              ],
            ),
          )
        )
    );
  }

  Widget createInfoMovie(MovieDetailResponse movieDetailResponse) {
    return ListView(
      children: [
        ListTile(
          title: Text("Presupuesto"),
          subtitle: Text((movieDetailResponse.budget.toString())==null ? '' : numberFormat.format(movieDetailResponse.budget)),
        ),
        ListTile(
          title: Text("Genero principal"),
          subtitle: Text((movieDetailResponse.genres.length > 0 ? movieDetailResponse.genres.first.name : "")),
        ),
        ListTile(
          title: Text("Popularidad"),
          subtitle: Text(movieDetailResponse.popularity.toString()),
        ),
        ListTile(
          title: Text("Compañia Productora"),
          subtitle: Text(movieDetailResponse.productionCompanies.first.name),
        ),
        ListTile(
          title: Text("Pais donde se produjo"),
          subtitle: Text(movieDetailResponse.productionCountries.first.name),
        )
      ],
    );
  }

  Widget createOverviewMovie(MovieDetailResponse movieDetailResponse) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Text(movieDetailResponse.overview),
    );
  }

}