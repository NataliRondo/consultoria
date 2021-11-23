import 'package:consultoria/app/domain/inputs/cita.dart';
import 'package:consultoria/app/ui/pages/register_appointment/controller/cita_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CitaList extends StatefulWidget {
  const CitaList({Key? key}) : super(key: key);

  @override
  _CitaListState createState() => _CitaListState();
}

class _CitaListState extends State<CitaList> {
  final citaService = CitaService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: citaService
          .getByEmail(FirebaseAuth.instance.currentUser!.email as String),
      builder: (context, snapshot) {
        List<Cita>? citas = snapshot.data as List<Cita>?;
        //!snapshot.hasData || snapshot.data == 0

        // ignore: unnecessary_null_comparison, prefer_is_empty
        if (citas == null || citas.length == 0) {
          // ignore: avoid_unnecessary_containers
          return const Padding(
            padding: EdgeInsets.all(50.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "No hay citas",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
        //List<Cita> citas = [];
        return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: citas.length,
          itemBuilder: (context, index) {
            Cita cita = citas[index];
            return ListTile(
              tileColor: cita.isCancelled()
                  ? Colors.red[100]
                  : const Color(0xFFE4FBFC),
              leading: Text(cita.turn > 0 ? cita.turn.toString() : ""),
              title: Center(
                child: Text(
                  cita.formattedDay(),
                ),
              ),
              subtitle: Center(
                child: Text(cita.status),
              ),
              trailing: cita.isCancelled()
                  ? IconButton(
                      mouseCursor: MouseCursor.uncontrolled,
                      icon: const Icon(Icons.cancel_outlined),
                      onPressed: () {},
                    )
                  : IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () async {
                        await citaService.cancel(cita);
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
