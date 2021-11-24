import 'package:consultoria/app/ui/global_controllers/session_controller.dart';
import 'package:consultoria/app/ui/pages/admin/cita/cita_form.dart';
import 'package:consultoria/app/ui/pages/admin/cita/list_cita_admin.dart';
import 'package:consultoria/app/ui/pages/menu/nav_admin.dart';
import 'package:consultoria/app/ui/pages/register_appointment/controller/cita_controller.dart';
import 'package:consultoria/app/ui/pages/register_appointment/controller/cita_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:table_calendar/table_calendar.dart';

final citaProvider = SimpleProvider(
  (_) => CitaController(sessionProvider.read),
);

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  CitaService citaService = CitaService();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    expanded = false;
  }

  @override
  Widget build(BuildContext context) {
    var count = 2;
    if (MediaQuery.of(context).size.width < 700) {
      count = 1;
    }
    return ProviderListener<CitaController>(
      provider: citaProvider,
      builder: (_, controller) {
        return Scaffold(
          drawer: const NavAdmin(),
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent.shade100,
            title: const Text('Citas - Admin'),

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
          body: GridView.count(
            padding: const EdgeInsets.only(top: 15.0),
            crossAxisCount: count,
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFede7f6),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TableCalendar(
                    locale: 'es_Es',
                    headerStyle: const HeaderStyle(
                        titleCentered: true, formatButtonVisible: false),
                    selectedDayPredicate: (day) => _selectedDay == day,
                    onDaySelected: (selectedDay, focusedDay) {
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
              ),
              Column(
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          expanded = !expanded;
                        });
                      },
                      child: const Text('Agregar Cita')),
                  Visibility(
                    visible: expanded,
                    child: CitaForm(
                      day: _selectedDay,
                      refreshDay: () {
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListCitaAdmin(
                        day: _selectedDay,
                      ),
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
