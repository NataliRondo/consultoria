import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/global_widgets/desing_custom.dart';
import 'package:consultoria/app/ui/pages/register_appointment/controller/cita_controller.dart';
import 'package:consultoria/app/ui/pages/register_appointment/controller/cita_service.dart';
import 'package:consultoria/app/ui/pages/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:table_calendar/table_calendar.dart';

final citaProvider = SimpleProvider(
  (_) => CitaController(sessionProvider.read),
);

class RegistrarCita extends StatefulWidget {
  const RegistrarCita({Key? key}) : super(key: key);

  @override
  State<RegistrarCita> createState() => _RegistrarCitaState();
}

class _RegistrarCitaState extends State<RegistrarCita> {
  CitaService citaService = CitaService();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener<CitaController>(
      provider: citaProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent.shade100,
            title: const Text('Registrar Cita'),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    const DesignCustom(),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 25, right: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Consumer(
                            builder: (_, ref, __) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      TableCalendar(
                                        selectedDayPredicate: (day) =>
                                            _selectedDay == day,
                                        onDaySelected:
                                            (selectedDay, focusedDay) {
                                          setState(() {
                                            _focusedDay = focusedDay;
                                            _selectedDay = selectedDay;
                                          });
                                        },
                                        focusedDay: _focusedDay,
                                        firstDay: DateTime.now(),
                                        lastDay: DateTime.now().add(
                                          const Duration(days: 365),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                      await citaService.create(
                                          FirebaseAuth.instance.currentUser!.email, _selectedDay);
                                          Navigator.popAndPushNamed(context, Routes.CITAHOME);
                                    },
                                        child: const Text('Agendar Cita'),
                                      ),
                                    ],
                                  ),

                                  //const Expanded(
                                  //  child: CitaList(),
                                  // ),
                                ],
                              );
                            },
                          ),
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
