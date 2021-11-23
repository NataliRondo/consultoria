import 'package:consultoria/app/domain/repositories/authentication_repository.dart';
import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/pages/routes/routes.dart';
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
