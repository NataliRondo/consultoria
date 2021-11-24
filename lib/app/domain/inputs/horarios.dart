import 'package:cloud_firestore/cloud_firestore.dart';

class Horarios {
    String hour;
    late DateTime day;
    late String status;
    //status
    //confirmado
    //cancelado
    //
    late String name;
    late String email;
    DocumentReference reference;

    String formattedDay() => '${day.day}/${day.month}/${day.year}';

    Horarios.fromSnapshot(DocumentSnapshot snapshot)
        : this.fromMap(snapshot.data.call() as Map<String, dynamic>, reference: snapshot.reference);

    Horarios.fromMap(Map<String, dynamic> map, {required this.reference})
        : hour = map['hour'],
          day = map['day'].toDate(),
          status = map['status'],
          email = map['email'];

    bool isCancelled() => status == 'cancelado';

  }
