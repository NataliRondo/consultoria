import 'dart:ui';

import 'package:consultoria/app/domain/repositories/authentication_repository.dart';
import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/pages/login/login_page.dart';
import 'package:consultoria/app/ui/pages/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

final navController = SimpleProvider(
  (_) => NavController(sessionProvider.read),
);

class NavController extends SimpleNotifier {
  late TabController tabController;
  NavController(SessionController _sessionController) {
    tabController = TabController(
      length: 2,
      vsync: NavigatorState(),
    );
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<NavController>(
        provider: navController,
        builder: (_, controller) {
          final String nombre =
              FirebaseAuth.instance.currentUser!.displayName as String;
          final String email =
              FirebaseAuth.instance.currentUser!.email as String;
          return Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(nombre, style: const TextStyle(color: Colors.blueGrey),),
                  accountEmail: Text(email, style: const TextStyle(color: Colors.blueGrey),),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xfffce4ec),
                      Colors.deepPurpleAccent.shade100
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  leading: const Icon(
                    Icons.home,
                    color: Colors.blueGrey,
                  ),
                  title: const Text('Inicio'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.HORARIO_HOME);
                  },
                  // ignore: prefer_const_constructors
                  leading: Icon(
                    Icons.receipt,
                    color: Colors.blueGrey,
                  ),
                  title: const Text('Registrar Horario'),
                ),
                ListTile(
                  onTap: () async {
                    await Get.i.find<AuthenticationRepository>().signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.blueGrey,
                  ),
                  title: const Text('Salir'),
                ),
              ],
            ),
          );
        });
  }
}
