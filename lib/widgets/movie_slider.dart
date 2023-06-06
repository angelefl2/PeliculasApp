import 'package:flutter/material.dart';
import 'package:peliculasapp/models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final Function onNextPage;
  final String? title;

  MovieSlider(
      {Key? key, required this.movies, required this.onNextPage, this.title})
      : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollControler = new ScrollController();

  // Ejecutamos codigo la primera vez que se construye el metodo
  @override
  void initState() {
    scrollControler.addListener(() {
      // 1*
      if (scrollControler.position.pixels >=
          scrollControler.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
    super.initState();
  }

  // Se llama cuando el widget muere
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO si no hay titulo no mostraoms el widget
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                "Populares",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollControler,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => _MoviePoster(
                  movie: widget.movies[index],
                  heroId: '${widget.title}-$index-${widget.movies[index].id}'),
            ),
          ),
        ],
      ),
    );
  }
}

// Este widget lo vamos a poner privado puesto que solo lo vamos a utilziar desde esta clase.
// Fernando dijo "Este widget no vivira en el mundo exterior"

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroId;

  const _MoviePoster({required this.movie, required this.heroId});

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    return Container(
      width: 160,
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage("assets/no-image.jpg"),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 135,
                  height: 200,
                ),
              ),
            ),
          ),
          SizedBox(height: 7),
          Text(
            movie.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


// 1*
/*
Este if controla la posicion actual del slider para lanzar la peticion de pedir peliculas cuando estemos 500 pixeles antes del final del sldier (ultiam peloicula) ahi relanzaremos lapeticion con pagina + 1 en el backend para que nos traiga la siguiente. 

*/