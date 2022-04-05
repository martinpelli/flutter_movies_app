import 'package:flutter/material.dart';
import 'package:flutter_movies_app/providers/movies_provider.dart';
import 'package:flutter_movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Movies on cinemas'),
          elevation: 0,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          CardSwiper(movies: moviesProvider.onDisplayMovies),
          MovieSlider(movies: moviesProvider.popularMovies, title: 'Populars')
        ])));
  }
}
