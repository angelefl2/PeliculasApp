import 'package:flutter/material.dart';
import 'package:peliculasapp/providers/ui_provider.dart';
import 'package:peliculasapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ConfigurationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text("Configuración"),
      ),
      body: _configurationBody(context),
    );
  }
}

_configurationBody(BuildContext context) {
  UiProvider uiProvider = Provider.of<UiProvider>(context);
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: ListView(
      children: [
        SwitchListTile(
            activeColor: Colors.blue,
            value: uiProvider.isDarkTheme,
            title: const Text("Tema oscuro"),
            onChanged: (val) {
              uiProvider.isDarkTheme = val;
            }),
      ],
    ),
  );
}
