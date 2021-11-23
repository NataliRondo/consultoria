import 'package:cloud_firestore/cloud_firestore.dart';

class Cita {
  late int turn;
  late DateTime day;
  //status
  //pendiente
  //cancelado
  //
  late String status;
  late String email;
  DocumentReference reference;

  String formattedDay() => '${day.day}/${day.month}/${day.year}';

  Cita.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data.call() as Map<String, dynamic>, reference: snapshot.reference);

  Cita.fromMap(Map<String, dynamic> map, {required this.reference})
      : turn = map['turn'],
        day = map['day'].toDate(),
        status = map['status'],
        email = map['email'];

  bool isCancelled() => status == 'cancelado';

}
