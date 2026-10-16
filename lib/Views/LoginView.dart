import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {

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
            onPressed: () {
              print("Iniciar sesión");
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