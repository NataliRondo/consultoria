
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultoria/app/domain/inputs/horarios.dart';
import 'package:flutter_meedu/flutter_meedu.dart';

class HorarioService extends SimpleNotifier{
  String _email = '';
  String get email => _email;

  Future<void> create(String? email, DateTime day, String hour) async {
    try {
      //var HorariosDelDia = await getBYDate(day);
      //var turno = 1;
     // HorariosDelDia!.forEach((element) => turno = max(element.turn + 1, turno));

      await FirebaseFirestore.instance.collection('Horarios').add(
        {'email': email, 'day': day, 'hour': hour, 'status': 'confirmado'},
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<Horarios>?> getByEmail(String email) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('Horarios')
          .where('email', isEqualTo: email)
          .get();

      List<Horarios> horarios = [];
      for (var element in snapshot.docs) {
        horarios.add(Horarios.fromSnapshot(element));
      }

      return horarios;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> cancel(Horarios horario) async {
    try {
      await FirebaseFirestore.instance
          .doc(horario.reference.path)
          .update({'status': 'cancelado'});
      await updateHorariosAfterTurn(horario.day , horario.hour);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Horarios>?> getBYDate(DateTime day) async {
    try {
      var nextDay = day.add(const Duration(days: 1));
      var snapshot = await FirebaseFirestore.instance
          .collection('Horarios')
          .where('day', isGreaterThanOrEqualTo: day, isLessThan: nextDay)
          .get();

      List<Horarios> horarios = [];
      for (var element in snapshot.docs) {
        horarios.add(Horarios.fromSnapshot(element));
      }

      //horarios.sort((a, b) => b.hour.hourOfPeriod.compareTo(a.hour.hourOfPeriod));

      return horarios;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> updateHorariosAfterTurn(DateTime day, String hour) async {
    try {
      var dbHorarios = await getBYDate(day);
      List<Horarios> horarios = [];
      // organizar por turno
      //horarios.sort((a, b) => b.hour.minute.compareTo(a.hour.minute));
      List<Future> futures = [];
      //actualiza turno por turno que ha sido cancelado
      for (var element in horarios) {
        futures.add(FirebaseFirestore.instance
            .doc(element.reference.path)
            .update({'hour': hour}));
        hour;
      }
      //regresa a la base de datos a actualizar
      await Future.wait(futures);
    } catch (e) {
      print(e);
      //return null;
    }
  }

  void onEmailChanged(String text) {
    _email = text;
  }
}
