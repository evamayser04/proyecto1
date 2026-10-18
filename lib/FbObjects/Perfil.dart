import 'package:cloud_firestore/cloud_firestore.dart';

class Perfil {
  String? uid;
  String? email;
  bool onboardingVisto;

  factory Perfil.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();

    return Perfil(
      uid: snapshot.id,
      email: data?['email'] as String?,
      onboardingVisto: data?['onboardingVisto'] == true,
    );
  }

  Perfil({this.uid, this.email, this.onboardingVisto = false});

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'onboardingVisto': onboardingVisto,
    };
  }
}