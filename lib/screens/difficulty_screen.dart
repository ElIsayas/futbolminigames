import 'package:flutter/material.dart';
import 'package:futbolminigames/screens/minigames_screen.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000033),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: Text(
                    'DIFICULTAD BOT',
                    style: TextStyle(
                      fontFamily: 'Bangers',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader =
                            LinearGradient(
                              colors: <Color>[
                                Colors.green[700]!,
                                Colors.green[900]!,
                              ],
                            ).createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                            ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(
                  children: [
                    _buildDifficultyButton('MUY FÁCIL', Colors.green[700]!, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MinigamesScreen(),
                        ),
                      );
                    }),
                    _buildDifficultyButton('FÁCIL', Colors.green[500]!, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MinigamesScreen(),
                        ),
                      );
                    }),
                    _buildDifficultyButton('NORMAL', Colors.yellow[600]!, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MinigamesScreen(),
                        ),
                      );
                    }),
                    _buildDifficultyButton('DIFÍCIL', Colors.orange[600]!, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MinigamesScreen(),
                        ),
                      );
                    }),
                    _buildDifficultyButton('EXPERTO', Colors.orange[800]!, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MinigamesScreen(),
                        ),
                      );
                    }),
                    _buildDifficultyButton('IMPOSIBLE', Colors.red[700]!, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MinigamesScreen(),
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 50),
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
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyButton(
    String text,
    Color color,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ElevatedButton(
        onPressed: onPressed,
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
