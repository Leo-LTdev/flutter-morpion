import 'package:flutter_application_1/grid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:scala_scoreboard/scala_scoreboard.dart';

class Apidb extends StatelessWidget {
  const Apidb({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Instruments', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final _future = Supabase.instance.client.from('users').select();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFF1A1F38), 
    body: FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF64FFDA)));
        }
        
        final List matches = snapshot.data!;

        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF252C4A), Color(0xFF1A1F38)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "RÉSULTATS BO5",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 30),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D3558),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Scoreboard(
                    rightSectionBackgroundColorWhenScrolled: const Color(0xFF2D3558),
                    header: ScoreboardHeader(
                      position: const ScoreboardHeaderCell(child: Text('#', style: TextStyle(color: Colors.white70))),
                      title: const ScoreboardHeaderCell(
                        shouldCenter: false,
                        child: Text('JOUEUR', style: TextStyle(color: Color(0xFF2D3558), fontWeight: FontWeight.bold)),
                      ),
                      dataColumns: List.generate(
                        matches.length,
                        (index) => ScoreboardHeaderCell(
                          child: Text('M${index + 1}', style: const TextStyle(color: Color(0xFF2D3558))),
                        ),
                      ),
                    ),
                    rows: [
                      _buildPlayerRow('1', 'Player 1', 'p1', matches, const Color.fromARGB(255, 44, 219, 178)),
                      _buildPlayerRow('2', 'Player 2', 'p2', matches, const Color.fromARGB(255, 196, 27, 27)),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF64FFDA),
                    foregroundColor: const Color(0xFF1A1F38),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 5,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MyGrid()),
                    );
                  },
                  child: const Text("CONTINUER LE BO5", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              
              const SizedBox(height: 15),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyGrid()),
                  );
                },
                child: const Text(
                  "Recommencer une partie",
                  style: TextStyle(color: Colors.white54, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
  }
}

ScoreboardRow _buildPlayerRow(String pos, String name, String key, List matches, Color color) {
  return ScoreboardRow(
    position: ScoreboardPositionCell(
      child: Text(pos, style: const TextStyle(color: Color(0xFF2D3558))),
    ),
    title: ScoreboardTitleCell(
      leading: LogoGroup.withImageUrls(['https://i.pravatar.cc/300?u=$key']),
      title: Text(name, style: const TextStyle(fontSize: 20, color: Color(0xFF2D3558), fontWeight: FontWeight.bold)),
    ),
    dataColumns: matches.map((match) {
      final score = match[key]?.toString() ?? '0';
      return ScoreboardCell(
        child: Text(
          score,
          style: TextStyle(
            fontSize: 20,
            color: score == '1' ? color : Color(0xFF2D3558), 
            fontWeight: score == '1' ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
    }).toList(),
  );
}