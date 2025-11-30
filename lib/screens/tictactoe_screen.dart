import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Para llamar a la API.
import 'dart:async'; // Para el Timer (reloj).
import 'dart:convert'; // Para procesar datos JSON de la API.

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  int _timeRemaining = 30; // Timer inicial de 30 segundos.
  Timer? _timer; // El reloj que cuenta segundos.
  Color _timerColor = Colors.green; // Color inicial del timer.
  String _searchText = ''; // Texto que escribe el usuario en el buscador.
  List<Map<String, dynamic>> _playerData =
      []; // Lista de jugadores de la API (datos reales).
  List<String> _suggestions = []; // Sugerencias para autocompletado.

  // API key (tuya, segura para local).
  static const String apiKey = 'b91668911062c7df1ef42b20b0bf4125';

  @override
  void initState() {
    super.initState();
    _startTimer(); // Inicia el timer.
    _fetchPlayers(
      '',
    ); // Fetch inicial de jugadores (query vacío para todos; ajusta si quieres específico).
  }

  @override
  void dispose() {
    _timer?.cancel(); // Para el timer al salir de la pantalla.
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
          if (_timeRemaining > 15) {
            _timerColor = Colors.green; // 30-15: verde.
          } else if (_timeRemaining > 10) {
            _timerColor = Colors.yellow; // 15-10: amarillo.
          } else if (_timeRemaining > 5) {
            _timerColor = Colors.orange; // 10-5: naranja.
          } else {
            _timerColor = Colors.red; // 5-0: rojo.
          }
        } else {
          timer.cancel(); // Para al llegar a 0.
          // Aquí puedes agregar lógica futura, como "tiempo acabado".
        }
      });
    });
  }

  Future<void> _fetchPlayers(String query) async {
    final url = query.isEmpty
        ? 'https://v3.football.api-sports.io/players?league=39&season=2023' // Ejemplo: Premier League 2023 (cambia league/season si quieres otros).
        : 'https://v3.football.api-sports.io/players?search=$query';
    final response = await http.get(
      Uri.parse(url),
      headers: {'x-apisports-key': apiKey},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _playerData = List<Map<String, dynamic>>.from(
          data['response'],
        ); // Guarda jugadores reales.
        _suggestions = _playerData
            .map(
              (player) =>
                  '${player['player']['name']} - ${player['statistics'][0]['games']['position']} ( ${player['player']['birth']['date']})',
            )
            .toList();
      });
    } else {
      // Si error (ej: límite API), muestra mensaje (pendiente: agrega SnackBar).
    }
  }

  void _updateSuggestions(String value) {
    setState(() {
      _searchText = value;
    });
    _fetchPlayers(value); // Llama API para filtrar en tiempo real.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF000033,
      ), // Fondo azul oscuro como en mockup.
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'TicTacToe',
                style: TextStyle(
                  fontFamily: 'Bangers',
                  fontSize: 32,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
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
                value: _timeRemaining / 30,
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
                    // Esquina superior izquierda: Icono FMG.
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
                    // Fila superior: Escudos de clubes (de API).
                    final clubLogo =
                        _playerData[index - 1]['statistics'][0]['team']['logo'];
                    return Card(
                      color: Colors.grey[800],
                      child: Center(child: Image.network(clubLogo, width: 50)),
                    );
                  } else if (index % 4 == 0 && _playerData.isNotEmpty) {
                    // Columna izquierda: Banderas (FlagCDN con nacionalidad ISO).
                    final nationality =
                        _playerData[(index ~/ 4) - 1]['player']['nationality']
                            .toLowerCase()
                            .substring(0, 2); // Ej: 'ar' para Argentina.
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
                    // Otras celdas: Nombres de jugadores, posiciones, etc.
                    final player =
                        _playerData[(index % 4) +
                            (index ~/ 4) -
                            2]; // Ajusta índice para datos.
                    return Card(
                      color: Colors.grey[800],
                      child: Center(
                        child: Text(
                          '${player['player']['name']}\n ${player['statistics'][0]['games']['position']}',
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
