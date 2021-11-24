// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:consultoria/app/inject_dependencies.dart';
import 'package:consultoria/app/ui/pages/admin/cita/cita_admin_home.dart';
import 'package:consultoria/app/ui/pages/login/login_page.dart';
import 'package:consultoria/app/ui/pages/menu/menu_page.dart';
import 'package:consultoria/app/ui/pages/splash/splash_admin/splash_screen_admin.dart';
import 'package:consultoria/app/ui/pages/splash/splash_login/splash_screen_login.dart';
import 'package:consultoria/app/ui/pages/splash/splash_menu/splash_screen_menu.dart';
import 'package:consultoria/app/utils/extra.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//import 'modulos/inicio.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await injectDependencies();
  await initializeDateFormatting().then((_) => runApp( Extra()));
}
