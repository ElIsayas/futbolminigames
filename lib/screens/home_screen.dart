import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {  // Cambié a Stateful para animaciones.
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;  // Controla la animación.
  late Animation<double> _gradientAnimation;  // Anima los stops del gradient.

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),  // Duración lenta de 10 segundos.
    )..repeat(reverse: true);  // Repite y revierte para movimiento continuo.

    _gradientAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();  // Limpia la animación al cerrar.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(  // Reconstruye con animación.
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,  // Empieza arriba.
                end: Alignment.bottomCenter,  // Termina abajo.
                colors: const [Colors.red, Colors.blue],  // Colores rojo a azul como en PNG.
                stops: [_gradientAnimation.value, 1.0 - _gradientAnimation.value],  // Anima el degradado.
              ),
            ),
            child: SafeArea(  // Evita notches del teléfono.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Espacia elementos: arriba, centro, abajo.
                children: [
                  const Padding(  // Espacio arriba para título.
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'FMG\nFUTBOLMINIGAMES',  // Título con salto de línea.
                      style: TextStyle(
                        fontFamily: 'Bangers',  // Font similar al PNG.
                        fontSize: 32,  // Tamaño grande.
                        fontWeight: FontWeight.bold,  // Negrita.
                        color: Colors.green,  // Verde como en PNG.
                      ),
                      textAlign: TextAlign.center,  // Centrado.
                    ),
                  ),
                  Column(  // Grupo de botones centrales.
                    children: [
                      _buildButton('assets/images/x_icon.png', 'UN JUGADOR', Colors.blue),  // Botón 1 con asset.
                      _buildButton('assets/images/square_icon.png', 'LOCAL', Colors.purple),  // Botón 2.
                      _buildButton('assets/images/triangle_icon.png', 'MULTIJUGADOR', Colors.green),  // Botón 3.
                      _buildButton('assets/images/circle_icon.png', 'COMPETITIVO', Colors.red),  // Botón 4.
                    ],
                  ),
                  Padding(  // Espacio abajo para íconos.
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Espaciados izquierda-derecha.
                      children: [
                        IconButton(
                          icon: Image.asset('assets/images/trophies.png', width: 50),  // Asset de trofeos.
                          onPressed: () {
                            // Lógica para leaderboard (agrega después, ej: Navigator.push).
                          },
                        ),
                        IconButton(
                          icon: Image.asset('assets/images/gear.png', width: 50),  // Asset de engranaje.
                          onPressed: () {
                            // Lógica para config (agrega después).
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildButton(String iconPath, String text, Color iconColor) {  // Función para crear botones repetidos.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),  // Espacio alrededor.
      child: ElevatedButton(
        onPressed: () {
          // Lógica al clic (agrega después, ej: navegar a otra pantalla).
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,  // Fondo negro como en PNG.
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),  // Redondeado.
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),  // Tamaño grande.
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,  // Ícono izquierda, texto derecha.
          children: [
            Image.asset(iconPath, width: 30, color: iconColor),  // Asset con color.
            const SizedBox(width: 16),  // Espacio entre ícono y texto.
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Bangers',  // Mismo font.
                fontSize: 24,  // Tamaño para texto de botones.
                color: Colors.white,  // Blanco.
                fontWeight: FontWeight.bold,  // Negrita.
              ),
            ),
          ],
        ),
      ),
    );
  }
}