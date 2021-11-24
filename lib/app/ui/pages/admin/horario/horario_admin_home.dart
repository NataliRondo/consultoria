import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/global_widgets/desing_custom.dart';
import 'package:consultoria/app/ui/pages/admin/horario/list_horario_admin.dart';
import 'package:consultoria/app/ui/pages/consultor/contoller/horario_controller.dart';
import 'package:consultoria/app/ui/pages/consultor/contoller/horario_service.dart';
import 'package:consultoria/app/ui/pages/consultor/horario_list.dart';
import 'package:consultoria/app/ui/pages/menu/nav_admin.dart';
import 'package:consultoria/app/ui/pages/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:table_calendar/table_calendar.dart';

final horarioProvider = SimpleProvider(
  (_) => HorarioController(sessionProvider.read),
);

class HorarioAdminHome extends StatefulWidget {
  const HorarioAdminHome({Key? key}) : super(key: key);
  @override
  _HorarioAdminHomeState createState() => _HorarioAdminHomeState();
}

class _HorarioAdminHomeState extends State<HorarioAdminHome> {
  HorarioService citaService = HorarioService();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  bool expanded = false;
  String _selectedTime = '8:00 AM';
  TimeOfDay _time = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    expanded = false;
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
    var count = 2;
    if (MediaQuery.of(context).size.width < 700) {
      count = 1;
    }
    return ProviderListener<HorarioController>(
      provider: horarioProvider,
      builder: (_, controller) {
        return Scaffold(
          drawer: const NavAdmin(),
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent.shade100,
            title: const Text('Horarios - Admin'),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    //const DesignCustom(),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 25, right: 20.0),
                        child: Consumer(
                          builder: (_, ref, __) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFede7f6),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      child: TableCalendar(
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
                                    ),
                                    const SizedBox(height: 15,),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ListHorarioAdmin(
                                        day: _selectedDay,
                                        hour: _time.format(context).toString(),
                                      ),
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
