import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatelessWidget {

  final FirebaseAuth faInstance = FirebaseAuth.instance;
  final TextEditingController userController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("PROYECTO1 DAM2627")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Text(
        "LOGIN",
        style: TextStyle(fontSize: 30, backgroundColor: Colors.red),
      ),
      TextField(
        controller: userController,
        decoration: InputDecoration(hintText: "Usuario"),
      ),
      TextField(
        obscureText: true,
        controller: passwordController,
        decoration: InputDecoration(hintText: "Contraseña"),
      ),
          TextButton(
            onPressed: () async{
              try {
                await faInstance.signInWithEmailAndPassword(
                  email: userController.text,
                  password: passwordController.text,
                );

                Navigator.pushReplacementNamed(context, '/homeview');
              } on FirebaseAuthException {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Correo o contraseña incorrectos')),
                );
                }
              },
            child: Text("Login"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/registerview');
            },
            child: Text("Registrarse"),
          ),
        ]
      )
    );
  }
}