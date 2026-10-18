import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto1/FbObjects/Perfil.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController controlador = PageController();
  int pagina = 0;
  bool guardando = false;

  Future<void> finalizar() async {
    final usuario = FirebaseAuth.instance.currentUser;

    if (usuario == null) {
      Navigator.pushReplacementNamed(context, '/loginview');
      return;
    }

    setState(() => guardando = true);

    try {
      final perfiles = FirebaseFirestore.instance
          .collection('Perfiles')
          .withConverter<Perfil>(
        fromFirestore: Perfil.fromFirestore,
        toFirestore: (perfil, _) => perfil.toFirestore(),
      );

      await perfiles.doc(usuario.uid).set(
        Perfil(
          uid: usuario.uid,
          email: usuario.email,
          onboardingVisto: true,
        ),
        SetOptions(merge: true),
      );

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/homeview');
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo guardar el onboarding')),
      );
    } finally {
      if (mounted) setState(() => guardando = false);
    }
  }

  @override
  void dispose() {
    controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controlador,
                onPageChanged: (nuevaPagina) {
                  setState(() => pagina = nuevaPagina);
                },
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdMejIiqCaYhoQ6TsCajgf6o7PT2o9S3TiVV_KsKF3zA&s=10',
                        height: 250,
                      ),
                      const Text('Mikasa: fuerza y protección'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7lg3YbTvQ3-60puReFxPE-nGwI632-wNxe4YcLCUnmw&s=10',
                        height: 250,
                      ),
                      const Text('Levi: disciplina y estrategia'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3PaGxsPAlh5_UvqiqTS794tjNrCWtA_OlqpbXK1VTBw&s=10',
                        height: 250,
                      ),
                      const Text('Eren: determinación y libertad'),
                    ],
                  ),
                ],
              ),
            ),
            if (guardando) const LinearProgressIndicator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: guardando ? null : finalizar,
                  child: const Text('Saltar'),
                ),
                FilledButton(
                  onPressed: guardando
                      ? null
                      : () {
                    if (pagina == 2) {
                      finalizar();
                    } else {
                      controlador.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(pagina == 2 ? 'Empezar' : 'Siguiente'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}