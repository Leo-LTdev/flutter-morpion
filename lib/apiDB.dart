import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:scala_scoreboard/scala_scoreboard.dart';
import 'package:flutter_application_1/grid.dart';

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
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final List matches = snapshot.data!;

          return Scoreboard(
            rightSectionBackgroundColorWhenScrolled: const Color.fromRGBO(250, 250, 250, 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 1),
                  blurRadius: 1,
                ),
              ],
            ),
            header: ScoreboardHeader(
              position: const ScoreboardHeaderCell(child: Text('#')),
              title: const ScoreboardHeaderCell(
                shouldCenter: false,
                child: Text('PLAYER', textAlign: TextAlign.left),
              ),
              dataColumns: List.generate(
                matches.length,
                (index) => ScoreboardHeaderCell(child: Text('M${index + 1}')),
              ),
            ),
            rows: [
              ScoreboardRow(
                position: const ScoreboardPositionCell(
                  trendMode: ScoreboardTrendMode.up,
                  child: Text('1'),
                ),
                title: ScoreboardTitleCell(
                  leading: LogoGroup.withImageUrls(['https://i.pravatar.cc/300?u=p1']),
                  title: const Text('Player 1'),
                ),
                dataColumns: matches.map((match) {
                  return ScoreboardCell(child: Text(match['p1']?.toString() ?? '0'));
                }).toList(),
              ),
              ScoreboardRow(
                position: const ScoreboardPositionCell(
                  trendMode: ScoreboardTrendMode.up,
                  child: Text('2'),
                ),
                title: ScoreboardTitleCell(
                  leading: LogoGroup.withImageUrls(['https://i.pravatar.cc/300?u=p2']),
                  title: const Text('Player 2'),
                ),
                dataColumns: matches.map((match) {
                  return ScoreboardCell(child: Text(match['p2']?.toString() ?? '0'));
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}