


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
    Routes.ADMIN_HOME
  ),
  Categoria(
    2,
    'Consultores',
    'usuario.png',
    Routes.REGISTRAR_CITAS
  ),
  Categoria(
    3,
    'Ubicación',
    'ubicacion.png',
    Routes.REGISTRAR_CITAS
  ),
  Categoria(
    4,
    'Acerca de...',
    'informacion.png',
    Routes.REGISTRAR_CITAS
  ),
  Categoria(
    5,
    'Citas',
    'informacion.png',
    Routes.CITAHOME
  )
];
