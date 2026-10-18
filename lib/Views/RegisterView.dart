import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto1/FbObjects/Perfil.dart';

class RegisterView extends StatelessWidget {

  final FirebaseAuth faInstance = FirebaseAuth.instance;
  final TextEditingController userController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController repasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "REGISTRO",
            style: TextStyle(fontSize: 30, backgroundColor: Colors.red),
          ),
          TextField(
            controller: userController,
            decoration: InputDecoration(hintText: "email"),
          ),
          TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(hintText: "Contraseña"),
          ),
          TextField(
            obscureText: true,
            controller: repasswordController,
            decoration: InputDecoration(hintText: "Repite la Contraseña"),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () async {
                  if (passwordController.text != repasswordController.text) {
                    print("LAS CONTRASEÑAS NO COINCIDEN");
                  } else {
                    try {
                      final credencial = await faInstance.createUserWithEmailAndPassword(
                        email: userController.text,
                        password: passwordController.text,
                      );
                      final usuario = credencial.user!;

                      final perfiles = FirebaseFirestore.instance
                          .collection('Perfiles')
                          .withConverter<Perfil>(
                        fromFirestore: Perfil.fromFirestore,
                        toFirestore: (perfil, _) => perfil.toFirestore(),
                      );

                      await perfiles.doc(usuario.uid).set(
                        Perfil(uid: usuario.uid, email: usuario.email),
                      );
                      Navigator.pushReplacementNamed(context, '/splashview');
                    } on FirebaseAuthException catch (e) {
                      String mensaje;

                      if (e.code == 'weak-password') {
                        mensaje = 'La contraseña es demasiado débil';
                      } else if (e.code == 'email-already-in-use') {
                        mensaje = 'Ese correo ya está registrado';
                      } else {
                        mensaje = 'No se pudo crear la cuenta';
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(mensaje)),
                      );
                    }
                  }
                },
                child: Text("Aceptar"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancelar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}