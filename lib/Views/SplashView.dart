import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto1/FbObjects/Perfil.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  static const String imagenUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRf9fVNpenE4dtvTChQEm8tJt0oGLPJ62E5kKa5K6gBjv6VSekRqU00_A1-&s=10';
  String? error;

  @override
  void initState() {
    super.initState();
    abrirApp();
  }

  Future<void> abrirApp() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final usuario = FirebaseAuth.instance.currentUser;
      String ruta;

      if (usuario == null) {
        ruta = '/loginview';
      } else {
        final perfiles = FirebaseFirestore.instance
            .collection('Perfiles')
            .withConverter<Perfil>(
          fromFirestore: Perfil.fromFirestore,
          toFirestore: (perfil, _) => perfil.toFirestore(),
        );

        final documento = await perfiles.doc(usuario.uid).get();
        ruta = documento.data()?.onboardingVisto == true
            ? '/homeview'
            : '/onboardingview';
      }

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, ruta);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        error = 'No se pudo abrir la aplicación. Comprueba la conexión.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imagenUrl,
              height: 220,
              loadingBuilder: (context, child, progreso) {
                if (progreso == null) return child;
                return const SizedBox(
                  height: 220,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) =>
              const SizedBox(
                height: 220,
                child: Center(child: Text('No se pudo cargar la imagen')),
              ),
            ),
          if (error == null) ...[
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            const Text('Cargando tu aplicación…'),
          ],
            if (error != null) ...[
              Text(error!),
              TextButton(onPressed: abrirApp, child: const Text('Reintentar')),
            ],
          ],
        ),
      ),
    );
  }
}