import 'dart:async';

import 'package:application_movies/helpers/debouncer.dart';
import 'package:application_movies/models/models.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '1dcc2a763556b80ca1307f63abbb852a';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration( milliseconds: 500)
  );

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionStreamController.stream;

  MoviesProvider(){

    getOnDisplayMovies();
    getPopularMovies();

  }

  Future<String>_getJsonData( String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key'  :  _apiKey,
      'language' :  _language,
      'page'     : '$page'
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    String url = '3/movie/now_playing';
    final String jsonData = await _getJsonData( url );
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    String url = '3/movie/popular';
    final String jsonData = await _getJsonData( url, _popularPage );
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [ ...popularMovies, ...popularResponse.results ];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast( int movieId ) async {

    if( movieCast.containsKey( movieId ) ) return movieCast[movieId]!;
    
    String url = '3/movie/$movieId/credits';
    final String jsonData = await _getJsonData( url );
    final creditsResponse = CreditsResponse.fromJson( jsonData );
    movieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies( String query ) async {
    String endpoint = '3/search/movie';

    final url = Uri.https(_baseUrl, endpoint, {
      'api_key'  :  _apiKey,
      'language' :  _language,
      'query'     : query
    });

    final response = await http.get( url );
    final searhResponse = SearchResponse.fromJson( response.body );
    return searhResponse.results;
  }

  void getSuggestionsByQuery( String searchTerm ) {
    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final results = await searchMovies( value );
      _suggestionStreamController.add( results );
    };

    final timer = Timer.periodic( const Duration( milliseconds: 300 ), ( _ ) { 
      debouncer.value = searchTerm;
    });

    Future.delayed( const Duration( milliseconds: 301 )).then(( _ ) => timer.cancel());
  }
}