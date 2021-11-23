import 'package:consultoria/app/ui/pages/splash/splash_admin/splash_screen_admin.dart';
import 'package:consultoria/app/ui/pages/splash/splash_login/splash_screen_login.dart';
import 'package:consultoria/app/ui/pages/splash/splash_menu/splash_screen_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class SplahVal extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  //final SessionController _sessionController;
  //final AuthenticationRepository _authRepository = Get.i.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              home: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const SplashLogin();
                    }
                    if (isAdmin(snapshot.data!.email)) {
                      return const SplasAdmin();
                    }

                    return const SplashMenu();
                  }),
            );
          }

          return const CircularProgressIndicator();
        });
  }
}


bool isAdmin(email) =>
    ["admin@consultor.com", "secre@consultor.com"].contains(email);
//pass 12345678
