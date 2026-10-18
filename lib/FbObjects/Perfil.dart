import 'package:cloud_firestore/cloud_firestore.dart';

class Perfil {
  String? uid;
  String? email;

  factory Perfil.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();

    return Perfil(
      uid: snapshot.id,
      email: data?['email'] as String?,
    );
  }

  Perfil({this.uid, this.email});

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
    };
  }
}