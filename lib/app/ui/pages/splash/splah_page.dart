import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/pages/splash/splash_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/router.dart' as router;

final splashProvider = SimpleProvider(
  (_) => SplashController(sessionProvider.read),
);

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ProviderListener<SplashController>(
      provider: splashProvider,
      onChange: (_, controller) async {

        final routeName = controller.routeName;
        if (routeName != null) {
          router.pushReplacementNamed(routeName);
        }
      },
      builder: (_, __) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

bool isAdmin(email) =>
    ["admin@consultor.com", "secre@consultor.com"].contains(email);
//pass 12345678
/*
class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder<SignUpData>(
                //stream: AuthStream().authStateChanges(),
                builder: (context, snapshot) {
              if (snapshot.data == null) {
                return LoginPage();
              }
              if (isAdmin(snapshot.data!.email)) {
                return AdminHome();
              }

              return Menu();
            });
          }
          return CircularProgressIndicator();
        });
  }
}

bool isAdmin(email) =>
    ["admin@consultor.com", "secre@consultor.com"].contains(email);
//pass 12345678
*/