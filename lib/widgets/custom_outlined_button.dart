import 'package:flutter/material.dart';

class customOutlinedButton extends StatelessWidget {
  final IconData icono;
  final String texto;

  const customOutlinedButton({required this.icono, required this.texto});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      onPressed: () {
        // Acción al presionar el botón
      },
      child: Row(
        children: [
          Icon(icono, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8.0),
          Text(
            texto,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ],
      ),
    );
  }
}
