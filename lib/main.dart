import 'package:flutter/material.dart';
import 'package:peliculasapp/providers/movies_provider.dart';
import 'package:peliculasapp/providers/ui_provider.dart';
import 'package:peliculasapp/screens/configuration_screen.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart'; // Utilizamos solamente este que llama al screens.dart, que exporta el resto

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          // 1*
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => UiProvider(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'details': (_) => DetailsScreen(),
        'configuration': (_) => ConfigurationScreen(),
      },
      // Modificamos el tema copiando la configuracion de themeData.light y cambiandola.
      theme: getTheme(context),
    );
  }

  ThemeData getTheme(BuildContext context) {
    UiProvider uiProvider = Provider.of<UiProvider>(context);
    ThemeData tema = uiProvider.isDarkTheme
        ? ThemeData.dark()
        : ThemeData.light()
            .copyWith(appBarTheme: const AppBarTheme(color: Colors.indigo));
    return tema;
  }
}


// 1*
// El lazy se utiliza para devolver la instancia en cuanto se llama al constructor de MoviesProvider().
// Por defecto esta en false, por tanto, hasta que ningun widget requiera de la instancia de MoviesProvider,
// esta no se va a crear verdaderamente. Poniendo lazy en false, obligamos a crear la instancia en el mismo
// momento que se le llama para disponer del Provider desde el momento 1 de inicio de la app
