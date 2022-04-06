import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_movies_app/providers/movies_provider.dart';

import '../models/models.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search movies or series';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('hola');
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
          child: Icon(Icons.movie_creation_outlined,
              color: Colors.black38, size: 130)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return _emptyContainer();

    final moviesPorvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesPorvider.searchMovies(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index) => _MovieItem(movies[index]));
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
          image: NetworkImage(movie.fullPosterImg),
          placeholder: AssetImage('assets/no-image.jpg'),
          width: 50,
          fit: BoxFit.contain),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
