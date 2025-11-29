import 'package:flutter/material.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  // 0 = vacío; 1 = Jugador X; 2 = Jugador O
  final List<int> _board = List<int>.filled(9, 0);
  int _currentPlayer = 1;
  String _status = "Turno: Jugador X";

  void _handleTap(int index) {
    if (_board[index] != 0) return; // ya hay un valor ahí
    setState(() {
      _board[index] = _currentPlayer;
      if (_checkWin(_currentPlayer)) {
        _status = 'Jugador ${_currentPlayer == 1 ? 'X' : 'O'} ha ganado!';
      } else if (!_board.contains(0)) {
        _status = 'Empate';
      } else {
        _currentPlayer = _currentPlayer == 1 ? 2 : 1;
        _status = 'Turno: Jugador ${_currentPlayer == 1 ? 'X' : 'O'}';
      }
    });
  }

  bool _checkWin(int player) {
    const List<List<int>> wins = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (final combo in wins) {
      if (_board[combo[0]] == player &&
          _board[combo[1]] == player &&
          _board[combo[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void _resetGame() {
    setState(() {
      for (int i = 0; i < 9; i++) _board[i] = 0;
      _currentPlayer = 1;
      _status = "Turno: Jugador X";
    });
  }

  Widget _buildCell(int index) {
    final value = _board[index];
    Widget child;
    if (value == 1) {
      child = const Icon(Icons.sports_soccer, color: Colors.black, size: 38);
    } else if (value == 2) {
      // placeholder: use a different icon for player O (e.g., star)
      child = const Icon(Icons.sports_baseball, color: Colors.orange, size: 38);
    } else {
      child = const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () => _handleTap(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: Colors.grey[400]!),
          color: Colors.green[50],
        ),
        child: Center(child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TicTacToe - Fútbol')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(_status, style: const TextStyle(fontSize: 18)),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, idx) => _buildCell(idx),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _resetGame, child: const Text('Reiniciar')),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Volver'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
