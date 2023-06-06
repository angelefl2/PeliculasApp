import 'dart:async';
// Creditos
// https://stackoverflow.com/a/52922130/7834829

// Este debouncer se utiliza en  la barra de busqueda de peliculas. Cuando escribimos texto cada vez que escribimos una letra se lanza una peticion a al API lo cual es tremendamente ineficiente. Lo que haremos sera retrasar ese lanzamiento a un tiempo despues de que el usuario deje de escribir. El argumento T lo que hace es definir el tipo como generico para que se le peuda pasar cualquier cosa al debouncer

class Debouncer<T> {
  Debouncer({required this.duration, this.onValue});

  final Duration duration;

  void Function(T value)? onValue;

  T? _value;
  Timer? _timer;

  T get value => _value!;

  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue!(_value!));
  }
}
