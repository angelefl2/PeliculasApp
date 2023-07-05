import 'package:flutter/material.dart';
import 'package:peliculasapp/providers/movies_provider.dart';
import 'package:peliculasapp/search/search_delegate.dart';
import 'package:peliculasapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //1*
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () =>
                showSearch(context: context, delegate: MovieSearchDelegate()),
          )
        ],
        elevation: 0,
        title: const Text("Principal"),
      ),
      // Este widget le da scroll a todo lo que contenga (pantalla infinita)
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              /* CardSwiper(
                movies: moviesProvider.onDisplayMovies,
              ),*/
              MovieSlider(
                movies: moviesProvider.upComingMovies,
                title: "Proximos lanzamientos", // opcional
                onNextPage: () => moviesProvider.getUpcomingMovies(),
              ),
              MovieSlider(
                movies: moviesProvider.onDisplayMovies,
                title: "En cines", // opcional
                onNextPage: () => {},
              ),
              MovieSlider(
                movies: moviesProvider.popularMovies,
                title: "Populares", // opcional
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
              MovieSlider(
                movies: moviesProvider.topRatedMovies,
                title: "Mas votadas", // opcional
                onNextPage: () => moviesProvider.getTopRatedMovies(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*1*
 Es un provider generico a menos que le espefiquemos el tipo <MoviesProvider> para que sepa que provider tiene que buscar. Necsitamos que se vaya al arbol de widgets y nos traiga la primera instancia que se encuentre de MoviesProvider, si no encontrara ninguna, creará una nueva siempre y cuando en su multiprovider, esté definido ese tipo. Esta instancia se encuentra en el main:

  ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          // 1*
          lazy: false,
        ),

  Notese que la instruccion final moviesProvider = Provider.of<MoviesProvider>(context, listen: true); tiene un listen: true. Por defecto esta en true incluso si no lo especificamos y quire decir que el widget se va a redibujar automaticamente cuando 
  haya un cambio en los datos del provider. Lo pondriamos en false cuando ejecutemos esa instruccion dentro de un widget que no pueda redibujarse (nos marcaria un error)


  
  */

  