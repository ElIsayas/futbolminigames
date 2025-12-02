import 'package:flutter/material.dart';
import 'package:futbolminigames/screens/difficulty_screen.dart'; // Importa Difficulty.

class HomeScreen extends StatelessWidget {
  // Cambié a Stateless (no animación).
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000033), // Fondo azul oscuro fijo.
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'FMG\nFUTBOLMINIGAMES',
                style: TextStyle(
                  fontFamily: 'Bangers',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: <Color>[Colors.green[700]!, Colors.green[900]!],
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: [
                _buildButton(
                  'assets/images/inicio/btn_X.png',
                  'UN JUGADOR',
                  Colors.blue,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DifficultyScreen(),
                      ),
                    );
                  },
                ),
                _buildButton(
                  'assets/images/inicio/btn_cuadrado.png',
                  'LOCAL',
                  Colors.purple,
                  null,
                ),
                _buildButton(
                  'assets/images/inicio/btn_triangulo.png',
                  'MULTIJUGADOR',
                  Colors.green,
                  null,
                ),
                _buildButton(
                  'assets/images/inicio/btn_circulo.png',
                  'COMPETITIVO',
                  Colors.red,
                  null,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Image.asset(
                      'assets/images/inicio/btn_Leaderboard.png',
                      width: 50,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/images/inicio/btn_Config.png',
                      width: 50,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    String iconPath,
    String text,
    Color iconColor,
    VoidCallback? onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              iconPath,
              width: 30,
              color: iconColor,
              errorBuilder: (context, error, stack) =>
                  const Icon(Icons.error, color: Colors.red),
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Bangers',
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
