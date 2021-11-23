import 'package:consultoria/app/domain/repositories/authentication_repository.dart';

import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/pages/routes/routes.dart';
import 'package:meedu/meedu.dart';

class SplashController extends SimpleNotifier {
  final SessionController _sessionController;
  final AuthenticationRepository _authRepository = Get.i.find();

  String? _routeName;
  String? get routeName => _routeName;

  SplashController(this._sessionController) {
    _init();
  }
//valida si existe usuario activo y redirige a su respectiva pagina 
//agregar una validacion para admin
  void _init() async {
    final user = await _authRepository.user;
    if (user != null) {
      _routeName = Routes.MENU;
      _sessionController.setUser(user);
      if(isAdmin(user.email)){
      _routeName = Routes.SPLASH_ADMIN;
      }
    } else {
      _routeName = Routes.LOGIN;
    }
    notify();
  }
}

/*
class SplashController extends SimpleNotifier {
  final SessionController _sessionController;
  //final _authRepository = Get.i.find<AuthenticationRepository>();
  final AuthenticationRepository _authRepository = Get.i.find();

  String? _routeName;
  String? get routeName => _routeName;
  SplashController(this._sessionController) {
    _init();
  }
  void _init() async {
    final user = await _authRepository.user;
    if (user != null) {
      _routeName = Routes.MENU;
      _sessionController.setUser(user);
      if(isAdmin(user.email)){
      _routeName = Routes.ADMIN;
      }
    } else {
      _routeName = Routes.LOGIN;
    }
    notify();
  }
}
*/
bool isAdmin(email) =>
    ["admin@consultor.com", "secre@consultor.com"].contains(email);
//pass 12345678
