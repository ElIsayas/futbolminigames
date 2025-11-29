import 'package:flutter/material.dart';
import 'package:futbolminigames/screens/home_screen.dart';
import 'screens/tictactoe_screen.dart';

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
        '/tictactoe': (context) => const TicTacToeScreen(),
      },
    );
  }
}
