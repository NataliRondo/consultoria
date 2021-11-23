
import 'package:consultoria/app/ui/pages/routes/app_routes.dart';
import 'package:consultoria/app/ui/pages/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;

class AdminApp extends StatelessWidget {
  const AdminApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, watch, __) {
      return MaterialApp(
        //title: 'Flutter FA',
        navigatorKey: router.navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.ADMIN_HOME,
        navigatorObservers: [
          router.observer,
        ],
        routes: appRoutes,
      );
    });
  }
}