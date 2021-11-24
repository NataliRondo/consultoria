

import 'package:consultoria/app/ui/pages/admin/cita/cita_admin_home.dart';
import 'package:consultoria/app/ui/pages/admin/horario/horario_admin_home.dart';
import 'package:consultoria/app/ui/pages/consultor/horario_home.dart';
import 'package:consultoria/app/ui/pages/consultor/register_horario_page.dart';
import 'package:consultoria/app/ui/pages/login/login_page.dart';
import 'package:consultoria/app/ui/pages/menu/menu_page.dart';
import 'package:consultoria/app/ui/pages/register_appointment/cita_home.dart';
import 'package:consultoria/app/ui/pages/register_appointment/register_appointment_page.dart';
import 'package:consultoria/app/ui/pages/registro/utils/register_page.dart';
import 'package:consultoria/app/ui/pages/reset_password/reset_password_page.dart';
import 'package:consultoria/app/ui/pages/routes/routes.dart';
import 'package:consultoria/app/ui/pages/splash/splah_page.dart';
import 'package:consultoria/app/ui/pages/splash/splash_admin/splash_screen_admin.dart';
import 'package:consultoria/app/ui/pages/splash/splash_login/splash_screen_login.dart';
import 'package:consultoria/app/ui/pages/splash/splash_menu/splash_screen_menu.dart';
import 'package:consultoria/app/ui/pages/splash/splash_valited.dart';
import 'package:consultoria/app/utils/extra.dart';
import 'package:flutter/cupertino.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.INICIAR: (_) => const  Extra(),
      Routes.SPLASH_MENU: (_) => const SplashMenu(),
      Routes.LOGIN: (_) => const LoginPage(),
      Routes.MENU: (_) => const Menu(),
      Routes.REGISTER: (_) => const RegisterPage(),
      Routes.RESET_PASSWORD: (_) => const ResetPasswordPage(),
      Routes.ADMIN_HOME: (_) => const AdminHome(),
      Routes.SPLASH_PAGE: (_) =>  SplashPage(),
      Routes.SPLASH_LOGIN: (_) => const SplashLogin(),
      Routes.REGISTRAR_CITAS: (_) => const RegistrarCita(),
      Routes.CITAHOME: (_) => const CitaHome(),
      Routes.SPLASH_ADMIN: (_) => const SplasAdmin(),

      Routes.SPLASH_VAL: (_) => SplahVal(),
      Routes.REGISTER_HORARIO: (_) => const RegistrarHorario(),
      Routes.HORARIO_HOME: (_) => const HorarioHome(),
      Routes.Horario_ADMIN_HOME: (_) => const HorarioAdminHome()
      //Routes.MyAp: (_) => MyApp()
    };