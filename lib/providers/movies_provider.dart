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

  MoviesProvider() {
    print("MoviesProvider incializado");
    getNowPlayingMovies();
    getPopularMovies();
  }

  getNowPlayingMovies() async {
    var url = Uri.https(_baseUrl, "3/movie/now_playing",
        {'api_key': _apiKey, 'languaje': _languaje, 'page': '1'});

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    onDisplayMovies = nowPlayingResponse.results;
    //1*
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, "3/movie/popular",
        {'api_key': _apiKey, 'languaje': _languaje, 'page': '1'});

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);
    popularMovies = [...onDisplayMovies, ...popularResponse.results];
    notifyListeners();
  }
}



//1*
// Extendemos esta clase de ChangeNotifier para usar este metodo. Cuando ejecutamos el metodo, ChangeNotifier dice a todos los widgets que este escuchando ese cambio que algo ha cambiado para que se redibujen con la informacion pertinente 