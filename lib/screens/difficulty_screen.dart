import 'package:flutter/material.dart';
import 'package:futbolminigames/screens/minigames_screen.dart'; // Importa la siguiente pantalla.

class DifficultyScreen extends StatefulWidget {
  const DifficultyScreen({super.key});

  @override
  _DifficultyScreenState createState() => _DifficultyScreenState();
}

class _DifficultyScreenState extends State<DifficultyScreen>
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
      body: Stack(
        children: [
          AnimatedBuilder(
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
              );
            },
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: const Text(
                    'DIFICULTAD BOT',
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
                    _buildDifficultyButton('MUY FÁCIL', Colors.green[700]!),
                    _buildDifficultyButton('FÁCIL', Colors.green[500]!),
                    _buildDifficultyButton('NORMAL', Colors.yellow[600]!),
                    _buildDifficultyButton('DIFÍCIL', Colors.orange[600]!),
                    _buildDifficultyButton('EXPERTO', Colors.orange[800]!),
                    _buildDifficultyButton('IMPOSIBLE', Colors.red[700]!),
                  ],
                ),
                const SizedBox(height: 50), // Espacio para flecha abajo.
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context); // Vuelve a la anterior (inicio).
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyButton(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MinigamesScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Bangers',
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
