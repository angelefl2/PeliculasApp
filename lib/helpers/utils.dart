import 'package:flutter/cupertino.dart';
import "package:url_launcher/url_launcher.dart";

lanzarUrl(String url, BuildContext context) async {
  Uri uri = Uri.parse(url);

  if (url.startsWith("https")) {
    await launch(url);
    // Arbir sitio web
    /* if (await canLaunchUrl(uri)) {
      await launchUrl(uri); 
    } else {
      throw "Could not launch $url";
    }*/
  } else {
    // Navigator.pushNamed(context, "mapa", arguments: scan);
  }
}
