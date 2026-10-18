import 'package:flutter/material.dart';

class BotBarStyle extends StatelessWidget {
  final int indiceSeleccionado;
  final ValueChanged<int> alSeleccionar;

  const BotBarStyle({
    super.key,
    required this.indiceSeleccionado,
    required this.alSeleccionar,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: indiceSeleccionado,
      onTap: alSeleccionar,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Inicio",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: "Lista",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view),
          label: "Cuadrícula",
        ),
      ],
    );
  }
}