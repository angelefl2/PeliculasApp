// To parse this JSON data, do
//
//     final streamProvider = streamProviderFromMap(jsonString);

import 'dart:convert';

class StreamProvider {
  int id;
  Map<String, Proveedor> results;

  StreamProvider({
    required this.id,
    required this.results,
  });

  factory StreamProvider.fromJson(String str) =>
      StreamProvider.fromMap(json.decode(str));

  factory StreamProvider.fromMap(Map<String, dynamic> json) => StreamProvider(
        id: json["id"],
        results: Map.from(json["results"])
            .map((k, v) => MapEntry<String, Proveedor>(k, Proveedor.fromMap(v))),
      );
}

class Proveedor {
  String link;
  List<Flatrate> flatrate;

  Proveedor({
    required this.link,
    required this.flatrate,
  });

  factory Proveedor.fromJson(String str) => Proveedor.fromMap(json.decode(str));

  factory Proveedor.fromMap(Map<String, dynamic> json) => Proveedor(
      link: json["link"],
      flatrate: json["flatrate"] != null
          ? List<Flatrate>.from(
              json["flatrate"].map((x) => Flatrate.fromMap(x)))
          : []);
}

class Flatrate {
  String logoPath;
  int providerId;
  String providerName;
  int displayPriority;

  Flatrate({
    required this.logoPath,
    required this.providerId,
    required this.providerName,
    required this.displayPriority,
  });

  factory Flatrate.fromJson(String str) => Flatrate.fromMap(json.decode(str));

  factory Flatrate.fromMap(Map<String, dynamic> json) => Flatrate(
        logoPath: json["logo_path"],
        providerId: json["provider_id"],
        providerName: json["provider_name"],
        displayPriority: json["display_priority"],
      );

  getFullProviderLogoUrl(String partialUrl) {
    return "https://www.themoviedb.org/t/p/original$partialUrl";
  }
}
