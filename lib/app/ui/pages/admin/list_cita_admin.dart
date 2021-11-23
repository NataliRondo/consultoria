import 'package:consultoria/app/domain/inputs/cita.dart';
import 'package:consultoria/app/ui/pages/register_appointment/controller/cita_service.dart';
import 'package:flutter/material.dart';

class ListCitaAdmin extends StatefulWidget {
  const ListCitaAdmin({Key? key, required this.day}) : super(key: key);
  final DateTime day;

  @override
  _CitaListState createState() => _CitaListState();
}

class _CitaListState extends State<ListCitaAdmin> {
  final citaService = CitaService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: citaService.getBYDate(widget.day),
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
                "No tiene citas",
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
              leading: Text(cita.turn.toString()),
              title: Center(
                child: Text(
                  cita.email,
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
                        await citaService.cancel(cita.reference);
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
