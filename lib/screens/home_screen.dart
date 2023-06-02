import 'package:flutter/material.dart';
import 'package:peliculasapp/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {},
          )
        ],
        elevation: 0,
        title: const Text("Peliculas en cines"),
      ),
      // Este widget le da scroll a todo lo que contenga (pantalla infinita)
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(),
            MovieSlider(),
          ],
        ),
      ),
    );
  }
}
