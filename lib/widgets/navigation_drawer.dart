import 'package:flutter/material.dart';
import 'widgets.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              _buildBody(context),
            ],
          ),
        ),
      ),
    );
  }

  _buildHeader(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.purple, Colors.blue])),
      height: size.height * 0.35,
      width: size.width,
      child: const Icon(
        Icons.person_pin,
        color: Colors.white,
        size: 100,
      ),
    );
  }

  _buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.5,
      child: Column(
        children: [
          const SizedBox(height: 15),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text("Principal"),
            onTap: () {
              Navigator.pushReplacementNamed(context, "home");
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Configuración"),
            onTap: () {
              Navigator.pushReplacementNamed(context, "configuration");
            },
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new_outlined),
            title: const Text("Salir"),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  _buildFooter(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          customOutlinedButton(icono: Icons.settings, texto: "Configuración"),
          SizedBox(width: 5),
          customOutlinedButton(
              icono: Icons.power_settings_new_outlined, texto: "Salir"),
        ],
      ),
    );
  }
}
