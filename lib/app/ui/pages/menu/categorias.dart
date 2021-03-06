


import 'package:consultoria/app/ui/pages/routes/routes.dart';

class Categoria {
  int id;
  String nombre;
  String foto;
  String ruta;

  Categoria(this.id, this.nombre, this.foto, this.ruta);
}

final obtenerMenu = [
  Categoria(
    1,
    'Registrar cita',
    'registro.png',
    Routes.REGISTRAR_CITAS
  ),
  Categoria(
    2,
    'Horario',
    'usuario.png',
    Routes.REGISTER_HORARIO
  ),
  Categoria(
    3,
    'Acerca de...',
    'informacion.png',
    Routes.REGISTRAR_CITAS
  ),
];
