import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/pages/register_appointment/controller/cita_controller.dart';
import 'package:consultoria/app/ui/pages/register_appointment/controller/cita_list.dart';
import 'package:consultoria/app/ui/pages/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

final citaProvider = SimpleProvider(
  (_) => CitaController(sessionProvider.read),
);

class CitaHome extends StatefulWidget {
  const CitaHome({Key? key}) : super(key: key);

  @override
  _CitaHomeState createState() => _CitaHomeState();
}

class _CitaHomeState extends State<CitaHome> {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<CitaController>(
      provider: citaProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent.shade100,
            title: const Text('Registrar Cita'),

            /** actions: [
              IconButton(
                onPressed: () =>
                    Navigator.popAndPushNamed(context, Routes.MENU),
                icon: const Icon(Icons.chevron_left_sharp),
              ),
            ], 
            onPressed: () => Navigator.popAndPushNamed(context, Routes.REGISTRAR_CITAS)
            
            */
          ),
          body: Scrollbar(
            thickness: 8,
            isAlwaysShown: true,
            child: ListView(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                      child: Center(
                        child: Column(
                          verticalDirection: VerticalDirection.down,
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextButton(
                                  onPressed: () => Navigator.popAndPushNamed(
                                          context, Routes.REGISTRAR_CITAS)
                                      .then((value) => {
                                        setState(() {}),
                                        }),
                                  child: const Text(
                                    'Agendar Cita',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Scrollbar(
                              thickness: 7,
                              //isAlwaysShown: true,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 13.0, left: 13.0, bottom: 10.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: const CitaList()),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
