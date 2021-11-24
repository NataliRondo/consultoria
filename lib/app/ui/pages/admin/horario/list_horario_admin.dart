import 'package:consultoria/app/domain/inputs/horarios.dart';
import 'package:consultoria/app/ui/pages/consultor/contoller/horario_service.dart';
import 'package:flutter/material.dart';

class ListHorarioAdmin  extends StatefulWidget {
  const ListHorarioAdmin ({Key? key, required this.day,required this.hour}) : super(key: key);
  final DateTime day;
  final String hour;

  @override
  _HorarioListState createState() => _HorarioListState();
}

class _HorarioListState extends State<ListHorarioAdmin> {
  final horarioService = HorarioService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: horarioService.getBYDate(widget.day),
      builder: (context, snapshot) {
        List<Horarios>? horarios = snapshot.data as List<Horarios>?;
        //!snapshot.hasData || snapshot.data == 0

        // ignore: unnecessary_null_comparison, prefer_is_empty
        if (horarios == null || horarios.length == 0) {
          // ignore: avoid_unnecessary_containers
          return const Padding(
            padding: EdgeInsets.all(50.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "No tiene horarios",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
        //List<horario> horarios = [];
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: horarios.length,
          itemBuilder: (context, index) {
            Horarios horario = horarios[index];
            return ListTile(
              tileColor: horario.isCancelled()
                  ? Colors.red[100]
                  : const Color(0xFFE4FBFC),
              //leading: Text(horario.turn > 0 ? horario.turn.toString() : ""),
              title: Center(
                child: Text(
                  horario.email +': '+ horario.hour,
                ),
              ),
              subtitle: Center(
                child: Text(horario.status),
              ),
              trailing: horario.isCancelled()
                  ? IconButton(
                      mouseCursor: MouseCursor.uncontrolled,
                      icon: const Icon(Icons.cancel_outlined),
                      onPressed: () {},
                    )
                  : IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () async {
                        await horarioService.cancel(horario);
                        setState(() {});
                      },
                    ),
            );
          },
        );
      },
    );
  }
}
