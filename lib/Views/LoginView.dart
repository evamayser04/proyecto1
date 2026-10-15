import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loginview extends StatelessWidget {

  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

    void funClickLogin() async {
      String user = userController.text;
      String pass = passwordController.text;
    }

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
      )
        ]
      )
    );
  }
}