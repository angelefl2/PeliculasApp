import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:peliculasapp/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '55cc2a209d599c9dc68ac1aba53a682e';
  final String _languaje = 'es-ES';
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies =
      []; // Aqui vamos a tener los resultados, es la lista que tendremos que escuchar desde los widgets
  int _popularPage = 0;

  MoviesProvider() {
    print("MoviesProvider incializado");
    getNowPlayingMovies();
    getPopularMovies();
  }
  // El argumento page va entre llaves porqe es opcional, si viene vacio toma el valor 1
  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endPoint,
        {'api_key': _apiKey, 'languaje': _languaje, 'page': "$page"});
    final response = await http.get(url);
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
}



//1*
// Extendemos esta clase de ChangeNotifier para usar este metodo. Cuando ejecutamos el metodo, ChangeNotifier dice a todos los widgets que este escuchando ese cambio que algo ha cambiado para que se redibujen con la informacion pertinente 