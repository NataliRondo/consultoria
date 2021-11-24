


import 'package:consultoria/app/ui/pages/routes/routes.dart';

class Categoria {
  int id;
  String nombre;
  String foto;
  String ruta;

  Categoria(this.id, this.nombre, this.foto, this.ruta);
}

final obtenerMenuAdmin = [
  Categoria(
    1,
    'Ver citas',
    'registro.png',
    Routes.ADMIN_HOME
  ),
  Categoria(
    2,
    'Consultores/horarios',
    'usuario.png',
    Routes.Horario_ADMIN_HOME
  ),
  Categoria(
    3,
    'Registrar horario',
    'calendar.png',
    Routes.REGISTER_HORARIO
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
