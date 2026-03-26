  import 'package:flutter/material.dart';
  import 'package:flutter_application_1/apiDB.dart';
  import 'package:flutter_application_1/grid.dart';
  import 'package:supabase_flutter/supabase_flutter.dart';

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
      url: 'https://dmvvzunzfafdsbcgnubf.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRtdnZ6dW56ZmFmZHNiY2dudWJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQzNTg1MjQsImV4cCI6MjA4OTkzNDUyNH0.7I5i5hEAII1zqVpQYKUyieuW-HNw6nTBUCip7uwqVVM',
    );

    runApp(const MyApp());
  }

  var mult = 1;

  class MyButton extends StatelessWidget {
    final Widget child;

    const MyButton({super.key, required this.child});

    @override
    Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () {
          const snackBar = SnackBar(content: Text('Tap'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          mult = mult * 10;
        },
        child: child,
      );
    }
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      const title = 'Grid List';

      return MaterialApp(
        
        home: Apidb());
    }
  }
