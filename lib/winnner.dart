import 'package:flutter/material.dart';
import 'package:flutter_application_1/apiDB.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResultPage extends StatelessWidget {
  final String winner; // On passe le nom du gagnant en paramètre

  const ResultPage({super.key, required this.winner});

  Future<bool> checkDB() async {
    final supabase = Supabase.instance.client;
    final List<dynamic> data = await supabase.from('users').select();
    var countP1 = 0;
    var countP2 = 0;
    for (var element in data) {
      if (element['p1'] == 1) {
        countP1++;
      } else if (element['p2'] == 1) {
        countP2++;
      }
    }
    if (countP1 >= 3) {
      return true;
    } else if (countP2 >= 3) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252C4A),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "FÉLICITATIONS !",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 20),
              Text(
                "Le joueur $winner a gagné !",
                textAlign: .center,
                style: const TextStyle(color: Colors.greenAccent, fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  final value = await checkDB();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(endGame: value,))
                  ); 
                },
                child: const Text("ScorBoard"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}