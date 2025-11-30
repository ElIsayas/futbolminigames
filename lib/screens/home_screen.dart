import 'package:flutter/material.dart';
import 'package:futbolminigames/screens/difficulty_screen.dart'; // Importa la nueva pantalla.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    _gradientAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [Colors.red, Colors.blue],
                stops: [
                  _gradientAnimation.value,
                  1.0 - _gradientAnimation.value,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'FMG\nFUTBOLMINIGAMES',
                      style: TextStyle(
                        fontFamily: 'Bangers',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
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
                        () {
                          Navigator.pushNamed(context, '/tictactoe');
                        },
                      ),
                      _buildButton(
                        'assets/images/inicio/btn_triangulo.png',
                        'MULTIJUGADOR',
                        Colors.green,
                        () {
                          // Lógica para multijugador (agrega después).
                        },
                      ),
                      _buildButton(
                        'assets/images/inicio/btn_circulo.png',
                        'COMPETITIVO',
                        Colors.red,
                        () {
                          // Lógica para competitivo (agrega después).
                        },
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
                          onPressed: () {
                            // Lógica para leaderboard (pendiente).
                          },
                        ),
                        IconButton(
                          icon: Image.asset(
                            'assets/images/inicio/btn_Config.png',
                            width: 50,
                          ),
                          onPressed: () {
                            // Lógica para config (pendiente).
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

  Widget _buildButton(
    String iconPath,
    String text,
    Color iconColor,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () {
          // Lógica al clic (agrega después).
        },
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
            Image.asset(iconPath, width: 30, color: iconColor),
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
