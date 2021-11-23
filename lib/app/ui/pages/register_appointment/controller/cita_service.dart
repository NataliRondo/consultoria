import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultoria/app/domain/inputs/cita.dart';

class CitaService {
  Future<void> create(String? email, DateTime day) async {
    try {
      var citasDelDia = await getBYDate(day);
      var turno = 1;
      citasDelDia!.forEach((element) => turno = max(element.turn + 1, turno));

      await FirebaseFirestore.instance.collection('citas').add(
        {'email': email, 'day': day, 'turn': turno, 'status': 'pendiente'},
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<Cita>?> getByEmail(String email) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('citas')
          .where('email', isEqualTo: email)
          .get();

      List<Cita> citas = [];
      for (var element in snapshot.docs) {
        citas.add(Cita.fromSnapshot(element));
      }

      citas.sort((a, b) => b.day.compareTo(a.day));

      return citas;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> cancel(Cita cita) async {
    try {
      await FirebaseFirestore.instance
          .doc(cita.reference.path)
          .update({'status': 'cancelado', 'turn': 0});
      await updateCitasAfterTurn(cita.day, cita.turn);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Cita>?> getBYDate(DateTime day) async {
    try {
      var nextDay = day.add(const Duration(days: 1));
      var snapshot = await FirebaseFirestore.instance
          .collection('citas')
          .where('day', isGreaterThanOrEqualTo: day, isLessThan: nextDay)
          .get();

      List<Cita> citas = [];
      for (var element in snapshot.docs) {
        citas.add(Cita.fromSnapshot(element));
      }

      citas.sort((a, b) => a.turn.compareTo(b.turn));

      return citas;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> updateCitasAfterTurn(DateTime day, int turn) async {
    try {
      var dbCitas = await getBYDate(day);
      List<Cita> citas = [];
      //filtrando turnos cancelados
      for (var element in dbCitas!) {
        if (element.turn >= turn) {
          citas.add(element);
        }
      }
      // organizar por turno
      citas.sort((a, b) => b.turn.compareTo(a.turn));
      List<Future> futures = [];
      //actualiza turno por turno que ha sido cancelado
      for (var element in citas) {
        futures.add(FirebaseFirestore.instance
            .doc(element.reference.path)
            .update({'turn': turn}));
            turn ++;
      }
      //regresa a la base de datos a actualizar
      await Future.wait(futures);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
