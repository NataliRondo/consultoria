


import 'package:consultoria/app/domain/inputs/horarios.dart';
import 'package:consultoria/app/domain/inputs/sign_up.dart';
import 'package:consultoria/app/ui/pages/consultor/contoller/horario_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HorarioList extends StatefulWidget {
  const HorarioList({Key? key}) : super(key: key);

  @override
  _HorarioListState createState() => _HorarioListState();
}

class _HorarioListState extends State<HorarioList> {
  final horarioService = HorarioService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: horarioService
          .getByEmail(FirebaseAuth.instance.currentUser!.email as String),
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
                "No hay horarios",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
        //List<Horario> Horarios = [];
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
              //leading: Text(Horario.turn > 0 ? Horario.turn.toString() : ""),
              title: Center(
                child: Text(
                  horario.hour + ' ' + horario.email,
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
