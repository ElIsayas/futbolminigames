import 'package:flutter/material.dart';
import 'package:futbolminigames/screens/tictactoe_screen.dart';

class MinigamesScreen extends StatelessWidget {
  const MinigamesScreen({super.key});

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
                    'MINIJUEGOS',
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
                    _buildMinigameButton('TICTACTOE', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TicTacToeScreen(),
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

  Widget _buildMinigameButton(String text, VoidCallback onPressed) {
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
