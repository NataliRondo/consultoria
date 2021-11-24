
import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/global_widgets/desing_custom.dart';
import 'package:consultoria/app/ui/pages/consultor/contoller/horario_controller.dart';
import 'package:consultoria/app/ui/pages/consultor/contoller/horario_service.dart';
import 'package:consultoria/app/ui/pages/register_appointment/controller/cita_controller.dart';
import 'package:consultoria/app/ui/pages/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:table_calendar/table_calendar.dart';

final horarioProvider = SimpleProvider(
  (_) => HorarioController(sessionProvider.read),
);

class RegistrarHorario extends StatefulWidget {
  const RegistrarHorario({Key? key}) : super(key: key);

  @override
  State<RegistrarHorario> createState() => _RegistrarHorarioState();
}

class _RegistrarHorarioState extends State<RegistrarHorario> {
  HorarioService horarioService = HorarioService();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  String _selectedTime = '8:00 AM';
  TimeOfDay _time = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _selectedTime;
    _time = TimeOfDay.now();
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: _time,
    ).then((value) {
      setState(() {
        _time = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener<HorarioController>(
      provider: horarioProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent.shade100,
            title: const Text('Registrar Horario'),
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
                                        locale: 'es_Es',
                                        headerStyle: const HeaderStyle(
                                            titleCentered: true,
                                            formatButtonVisible: false),
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
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              _showTimePicker();
                                            },
                                            icon: const Icon(Icons.alarm),
                                          ),
                                          Text(
                                            'Hora ${_time.format(context).toString()}',
                                          ),
                                        ],
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await horarioService.create(
                                              FirebaseAuth
                                                  .instance.currentUser!.email,
                                              _selectedDay,
                                              _time.format(context).toString());
                                          Navigator.popAndPushNamed(
                                              context, Routes.HORARIO_HOME);
                                        },
                                        child: const Text('Agregar Horario'),
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
