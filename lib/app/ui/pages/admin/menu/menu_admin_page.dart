import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/pages/admin/menu/categorias.dart';
import 'package:consultoria/app/ui/pages/menu/controller/menu_controller.dart';
import 'package:consultoria/app/ui/pages/menu/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

final menuProvider = SimpleProvider(
  (_) => MenuController(sessionProvider.read),
);

class MenuAdminP extends StatelessWidget {
  const MenuAdminP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<MenuController>(
        provider: menuProvider,
        builder: (_, controller) {
          return Scaffold(
            drawer: const NavBar(),
            appBar: AppBar(
              backgroundColor: Colors.deepPurpleAccent.shade100,
              title: const Text('inicio - Admin'),
            ),
            body: Center(
              child: GridView.builder(
                itemCount: obtenerMenuAdmin.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: const Color(0xfffce4ec),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, obtenerMenuAdmin[index].ruta),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/' + obtenerMenuAdmin[index].foto,
                            width: 70,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(obtenerMenuAdmin[index].nombre),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
