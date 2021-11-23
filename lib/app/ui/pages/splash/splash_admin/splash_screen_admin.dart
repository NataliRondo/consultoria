// ignore_for_file: non_constant_identifier_names

import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/pages/admin/admin_app.dart';
import 'package:consultoria/app/ui/pages/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_meedu/meedu.dart';

final splashProvider =
    SimpleProvider((_) => SplashController(sessionProvider.read));

class SplasAdmin extends StatefulWidget {
  const SplasAdmin({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplasAdmin> {
  //final _controller = SplashController(sessionProvider.read);
  @override
  void initState() {
    super.initState();
    Timer(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ProviderListener<SplashController>(
      provider: splashProvider,
      onChange: (_, controller) {
      },
      builder: (_, __) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                //decoration: BoxDecoration(color: Colors.deepPurpleAccent[100]),
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    const Color(0xfffce4ec),
                    Colors.deepPurpleAccent.shade100
                  ], begin: Alignment.centerLeft, end: Alignment.bottomRight),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80.0,
                          child: Image(
                            image: AssetImage('assets/img/logo1-modified.png'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                        Text(
                          'Bienvenido',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const CircularProgressIndicator(
                          color: Colors.blueGrey,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 40.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

void Timer(BuildContext context) {
  Future.delayed(
    //para ir a otra pantalla despues de 6 segundos y cuando regrese no se muestre el splash y se cierre la app
    const Duration(milliseconds: 3000),
    () => Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const AdminApp()),
    (Route<dynamic> route) => false),
  );
  //Navigator.push(context, MaterialPageRoute(builder: (context) => const Inicio()),)
  // MaterialPageRoute(builder: (context) => LoginPage()),
}
