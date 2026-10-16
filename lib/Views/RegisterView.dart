import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {

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
                onPressed: () {
                  if (passwordController.text != repasswordController.text) {
                    print("LAS CONTRASEÑAS NO COINCIDEN");
                  } else {
                    print("Registro correcto");
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