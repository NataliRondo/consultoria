import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/pages/consultor/contoller/horario_controller.dart';
import 'package:consultoria/app/ui/pages/consultor/horario_list.dart';
import 'package:consultoria/app/ui/pages/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

final consultorProvider = SimpleProvider(
  (_) => HorarioController(sessionProvider.read),
);

class HorarioHome extends StatefulWidget {
  const HorarioHome({Key? key}) : super(key: key);

  @override
  _HorarioHomeState createState() => _HorarioHomeState();
}

class _HorarioHomeState extends State<HorarioHome> {
  @override
  Widget build(BuildContext context) {
    return ProviderListener<HorarioController>(
      provider: consultorProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent.shade100,
            title: const Text('Registrar Horario'),
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
                                  onPressed: () => Navigator.pushNamed(
                                          context, Routes.REGISTER_HORARIO)
                                      .then((value) => {
                                        setState(() {}),
                                        }),
                                  child: const Text(
                                    'Agregar Horario',
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
                                        child: const HorarioList()),
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
