import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  int _timeRemaining = 60; // Empieza en 60 seg, como tu mockup.
  Timer? _timer;
  Color _timerColor = Colors.green;
  String _searchText = '';
  List<Map<String, dynamic>> _playerData = [];
  List<String> _suggestions = [];

  // Tu API key.
  static const String apiKey = 'b91668911062c7df1ef42b20b0bf4125';

  @override
  void initState() {
    super.initState();
    _startTimer();
    _fetchPlayers(''); // Carga jugadores famosos al inicio (toda historia).
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return; // Evita errores si pantalla cierra.
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
          if (_timeRemaining > 30)
            _timerColor = Colors.green;
          else if (_timeRemaining > 20)
            _timerColor = Colors.yellow;
          else if (_timeRemaining > 10)
            _timerColor = Colors.orange;
          else
            _timerColor = Colors.red;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _pauseGame() {
    _timer?.cancel();
  }

  void _resumeGame() {
    _startTimer();
  }

  // BUSCA JUGADORES DE TODA LA HISTORIA (sin año/liga fija).
  Future<void> _fetchPlayers(String query) async {
    final url = query.isEmpty
        ? 'https://v3.football.api-sports.io/players?search=ronaldo,messi,maradona,pele,beckham,cruyff,zidane,neymar,mbappe,haaland'
        : 'https://v3.football.api-sports.io/players?search=$query';
    final response = await http.get(
      Uri.parse(url),
      headers: {'x-apisports-key': apiKey},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _playerData = List<Map<String, dynamic>>.from(data['response']);
        _suggestions = _playerData
            .map(
              (player) =>
                  '${player['player']['name']} - ${player['statistics'][0]['games']['position']} (${player['player']['birth']['date']})',
            )
            .toList();
      });
    }
  }

  void _updateSuggestions(String value) {
    setState(() {
      _searchText = value;
    });
    _fetchPlayers(value);
  }

  void _showPauseDialog() {
    _pauseGame(); // Pausa timer.
    showDialog(
      context: context,
      barrierDismissible: false, // No cierra tocando fuera.
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(
            0xFF000033,
          ).withOpacity(0.95), // Fondo azul semi-transparente.
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'PAUSE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Bangers',
              fontSize: 40,
              color: Colors.green,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _pauseButton('REANUDAR', Colors.green, () {
                Navigator.of(context).pop(); // Cierra dialog.
                _resumeGame(); // Reanuda timer.
              }),
              const SizedBox(height: 10),
              _pauseButton('MINIJUEGOS', Colors.blue, () {
                Navigator.of(context).pop(); // Cierra dialog.
                Navigator.popUntil(
                  context,
                  ModalRoute.withName('/minigames'),
                ); // Vuelve a Minijuegos (siguiendo consejo VS Code).
              }),
              const SizedBox(height: 10),
              _pauseButton('INICIO', Colors.red, () {
                Navigator.of(context).pop(); // Cierra dialog.
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                ); // Vuelve a Inicio (siguiendo consejo VS Code).
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _pauseButton(String text, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Bangers',
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000033),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.pause_circle_outline,
                      color: Colors.green,
                      size: 30,
                    ),
                    onPressed:
                        _showPauseDialog, // Abre la ventana pequeña de pausa.
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'TICTACTOE',
                    style: TextStyle(
                      fontFamily: 'Bangers',
                      fontSize: 32,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_timeRemaining : $_timeRemaining',
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Change Teams U'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Skip Turn',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const Text('Turn: x', style: TextStyle(color: Colors.white)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearProgressIndicator(
                value: _timeRemaining / 60,
                backgroundColor: Colors.grey,
                color: _timerColor,
                minHeight: 10,
              ),
            ),
            Text(
              'Time remaining: $_timeRemaining seconds',
              style: const TextStyle(color: Colors.white),
            ),
            DropdownButton<String>(
              value: 'Medium',
              items: const [
                DropdownMenuItem(value: 'Medium', child: Text('Medium')),
              ],
              onChanged: (value) {},
              hint: const Text('Choose Bot Difficulty'),
            ),
            DropdownButton<String>(
              value: 'Only top countries available (easy)',
              items: const [
                DropdownMenuItem(
                  value: 'Only top countries available (easy)',
                  child: Text('Only top countries available (easy)'),
                ),
              ],
              onChanged: (value) {},
              hint: const Text('Mode'),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Card(
                      color: Colors.grey[800],
                      child: Center(
                        child: Image.asset(
                          'assets/images/fmg_icon.png',
                          width: 50,
                        ),
                      ),
                    );
                  } else if (index < 4 && _playerData.isNotEmpty) {
                    final clubLogo =
                        _playerData[index - 1]['statistics'][0]['team']['logo'];
                    return Card(
                      color: Colors.grey[800],
                      child: Center(child: Image.network(clubLogo, width: 50)),
                    );
                  } else if (index % 4 == 0 && _playerData.isNotEmpty) {
                    final nationality =
                        _playerData[(index ~/ 4) - 1]['player']['nationality']
                            .toLowerCase()
                            .substring(0, 2);
                    return Card(
                      color: Colors.grey[800],
                      child: Center(
                        child: Image.network(
                          'https://flagcdn.com/w320/$nationality.png',
                          width: 50,
                        ),
                      ),
                    );
                  } else if (_playerData.isNotEmpty) {
                    final player = _playerData[(index % 4) + (index ~/ 4) - 2];
                    return Card(
                      color: Colors.grey[800],
                      child: Center(
                        child: Text(
                          '${player['player']['name']}\n${player['statistics'][0]['games']['position']}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  return Card(
                    color: Colors.grey[800],
                    child: Center(
                      child: Text(
                        'Celda $index',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Autocomplete<String>(
                optionsViewBuilder: (context, onSelected, options) {
                  return ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(options.elementAt(index)));
                    },
                  );
                },
                optionsMaxHeight: 200.0,
                initialValue: TextEditingValue(text: _searchText),
                onSelected: (String selection) {
                  _updateSuggestions(selection);
                },
                fieldViewBuilder:
                    (context, controller, focusNode, onFieldSubmitted) {
                      controller.text = _searchText;
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        onChanged: _updateSuggestions,
                        decoration: const InputDecoration(
                          hintText: 'Buscar jugador...',
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return _suggestions;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
