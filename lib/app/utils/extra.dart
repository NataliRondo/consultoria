// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:consultoria/app/ui/pages/routes/app_routes.dart';
import 'package:consultoria/app/ui/pages/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;

//import 'modulos/inicio.dart';

// ignore: use_function_type_syntax_for_parameters


class Extra extends StatelessWidget {
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  const Extra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, watch, __) {
      return MaterialApp(
        //title: 'Flutter FA',
        navigatorKey: router.navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.SPLASH_PAGE,
        navigatorObservers: [
          router.observer,
        ],
        routes: appRoutes,
      );
    });
  }
}

bool isAdmin(email) =>
    ["admin@consultor.com", "secre@consultor.com"].contains(email);
//pass 12345678