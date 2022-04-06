import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_movies_app/providers/movies_provider.dart';
import 'package:flutter_movies_app/search/search_delegate.dart';
import 'package:flutter_movies_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Movies on cinemas'),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: MovieSearchDelegate()),
                icon: Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          CardSwiper(movies: moviesProvider.onDisplayMovies),
          MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Populars',
              onNextPage: () => moviesProvider.getPopularMovies())
        ])));
  }
}
