import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculasapp/helpers/debauncer.dart';

import 'package:peliculasapp/models/models.dart';
import 'package:peliculasapp/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '55cc2a209d599c9dc68ac1aba53a682e';
  final String _languaje = 'es-ES';
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> upComingMovies = [];
  Map<int, List<Cast>> moviesCast = {};
  int _popularPage = 0;
  int _topRatedPage = 0;
  int _upcomingPage = 0;
  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  // Con broadcast definimos que varios elementos pueden conectarse para escuchar el stream
  final StreamController<List<Movie>> _suggestionStreamController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      _suggestionStreamController.stream;

  MoviesProvider() {
    getNowPlayingMovies();
    getPopularMovies();
    getTopRatedMovies();
    getUpcomingMovies();
  }
  // El argumento page va entre llaves porqe es opcional, si viene vacio toma el valor 1
  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endPoint, {
      'api_key': _apiKey,
      'language': _languaje,
      'page': "$page",
      'region': "ES"
    });
    final response = await http.get(url);
    print(url);
    return response.body;
  }

  getNowPlayingMovies() async {
    final jsonData = await _getJsonData("3/movie/now_playing");
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    //1*
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData("3/movie/popular", _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  getTopRatedMovies() async {
    _topRatedPage++;
    final jsonData = await _getJsonData("3/movie/top_rated", _topRatedPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    topRatedMovies = [...topRatedMovies, ...popularResponse.results];
    notifyListeners();
  }

  getUpcomingMovies() async {
    _upcomingPage++;
    final jsonData = await _getJsonData("/3/movie/upcoming", _upcomingPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    upComingMovies = [...upComingMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    // 2*
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final jsonData = await _getJsonData("/3/movie/$movieId/credits");
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, "/3/search/movie",
        {'api_key': _apiKey, 'language': _languaje, 'query': "$query"});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm, Duration duracion) {
    debouncer.value = "";
    debouncer.onValue = (value) async {
      //3*
      final results = await searchMovies(searchTerm);
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(duracion, (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(duracion).then((_) => timer.cancel());
  }

  Future<Proveedor?> getStreamProvider(int movieId) async {
    //if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final jsonData = await _getJsonData("/3/movie/$movieId/watch/providers");
    final creditsResponse = StreamProvider.fromJson(jsonData);

    if (creditsResponse.results.containsKey("ES")) {
      Proveedor proveedores = creditsResponse.results["ES"]!;
      return proveedores;
    } else {
      return null;
    }
  }
}



/*1*
Extendemos esta clase de ChangeNotifier para usar este metodo. Cuando ejecutamos el metodo, ChangeNotifier dice a todos los widgets que este escuchando ese cambio que algo ha cambiado para que se redibujen con la informacion pertinente 
*/

/*2* 
Esta instruccion lo que hace basicamente es detrminar si en el arbol de widgets ya se encuentra la clave que estamos pidiendo al api, si se encuentra quiere decir que la informacion esta en memoria y no necesitamos volver a realizar la peticion, en caso contrario realizamos la petiticion. Esto se utiliza para ser mas eficiente y no lanzar peticiones innecesarias si tenemos realmetne la informacion que necesitamos.
*/


/*3* 
Lo que hacemos aqui es esperar con el debouncer para lanzar la peticion al http y mandar los resutlados de dicha peticion al StreamBuilder que esta escuchando en search_delegate.dart
*/