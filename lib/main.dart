import 'package:flutter/material.dart';
import 'package:futbolminigames/screens/home_screen.dart';
import 'package:futbolminigames/screens/difficulty_screen.dart';
import 'package:futbolminigames/screens/minigames_screen.dart';
import 'package:futbolminigames/screens/tictactoe_screen.dart';

void main() {
  runApp(const FMGApp());
}

class FMGApp extends StatelessWidget {
  const FMGApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FMG - Fútbol MiniGames',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/difficulty': (context) => const DifficultyScreen(),
        '/minigames': (context) => const MinigamesScreen(),
        '/tictactoe': (context) => const TicTacToeScreen(),
      },
    );
  }
}
