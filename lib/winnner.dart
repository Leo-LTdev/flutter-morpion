import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String winner; // On passe le nom du gagnant en paramètre

  const ResultPage({super.key, required this.winner});

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
                onPressed: () {
                  
                  // Navigator.pushReplacement(); 
                },
                child: const Text("Rejouer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}