import 'package:cloud_firestore/cloud_firestore.dart';

class Perfil {
  String? uid;
  String? email;
  String? nombre;
  int? edad;
  bool onboardingVisto;

  Perfil({
    this.uid,
    this.email,
    this.nombre,
    this.edad,
    this.onboardingVisto = false,
  });

  factory Perfil.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();

    return Perfil(
      uid: snapshot.id,
      email: data?['email'] as String?,
      nombre: data?['nombre'] as String?,
      edad: (data?['edad'] as num?)?.toInt(),
      onboardingVisto: data?['onboardingVisto'] == true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (email != null) 'email': email,
      if (nombre != null) 'nombre': nombre,
      if (edad != null) 'edad': edad,
      'onboardingVisto': onboardingVisto,
    };
  }
}