import 'package:flutter/cupertino.dart';

import '../models/models.dart';

import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = 'b034037d15bbe9390d5819a0b75efd0c';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularPage = 0;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<dynamic> _httpResponseBody(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, '/3/movie/$endpoint',
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);

    return response.body;
  }

  getOnDisplayMovies() {
    _httpResponseBody('now_playing').then((response) {
      final nowPlayingResponse = NowPlayingResponse.fromJson(response);
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
    });
  }

  getPopularMovies() async {
    _popularPage++;

    _httpResponseBody('popular', _popularPage).then((response) {
      final popularResponse = PopularResponse.fromJson(response);
      popularMovies = [...popularMovies, ...popularResponse.results];
      notifyListeners();
    });
  }
}