import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculasapp/helpers/utils.dart';
import 'package:peliculasapp/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:peliculasapp/models/models.dart';

class WhereToSeeCard extends StatelessWidget {
  final int movieID;

  const WhereToSeeCard(this.movieID);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return Container(
      height: 80,
      child: FutureBuilder(
        future: moviesProvider.getStreamProvider(movieID),
        builder: (_, AsyncSnapshot<Proveedor?> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                "Plataforma desconocida",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            );
          }

          final Proveedor proveedor = snapshot.data!;
          return SizedBox(
            width: double.infinity,
            height: 70,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: proveedor.flatrate.length,
                itemBuilder: (context, index) => _ProviderCard(
                    proveedor: proveedor, flatrate: proveedor.flatrate[index])),
          );
        },
      ),
    );
  }
}

class _ProviderCard extends StatelessWidget {
  final Proveedor proveedor;
  final Flatrate flatrate;

  const _ProviderCard({required this.proveedor, required this.flatrate});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => lanzarUrl(proveedor.link, context),
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        height: 70,
        width: 50,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                height: 50,
                width: 50,
                placeholder: const AssetImage("assets/loading.gif"),
                image: NetworkImage(
                    flatrate.getFullProviderLogoUrl(flatrate.logoPath)),
                fit: BoxFit.cover,
              ),
            ),
            Text(
              flatrate.providerName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
