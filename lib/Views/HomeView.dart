import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto1/insLib/BotBarStyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto1/FbObjects/Perfil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int indiceSeleccionado = 0;

  late final streamElementos = FirebaseFirestore.instance
      .collection('Elementos')
      .withConverter<Perfil>(
    fromFirestore: Perfil.fromFirestore,
    toFirestore: (perfil, _) => perfil.toFirestore(),
  )
      .snapshots();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Expanded(
          child: indiceSeleccionado == 1
              ? StreamBuilder<QuerySnapshot<Perfil>>(
                  stream: streamElementos,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error al cargar los datos'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final documentos = snapshot.data!.docs;

                    if (documentos.isEmpty) {
                      return const Center(child: Text('No hay elementos'));
                    }

                    return ListView(
                      children: documentos.map((documento) {
                        final elemento = documento.data();
                        return ListTile(
                          title: Text(elemento.nombre ?? ''),
                          subtitle: Text('Edad: ${elemento.edad ?? 0}'),
                        );
                      }).toList(),
                    );
                  },
                )
              : Center(
                  child: Text(
                    indiceSeleccionado == 0 ? 'INICIO' : 'CUADRÍCULA',
                  ),
                ),
        ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/loginview');
            },
            child: const Text("Cerrar sesión"),
          ),
        ],
      ),
      bottomNavigationBar: BotBarStyle(
        indiceSeleccionado: indiceSeleccionado,
        alSeleccionar: (indice) {
          setState(() {
            indiceSeleccionado = indice;
          });
        },
      ),
    );
  }
}
