import 'package:flutter/material.dart';

void main() {
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
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: GridView.count(
          crossAxisCount: 2,
          children: [
            Row(
              children: [
                MyButton(
                  child: Expanded(
                    child: Column(
                      children: List.generate(10, (index) {
                        return Center(
                          child: Text(
                            'Eur : ${index * mult + 1}',
                            style: TextTheme.of(context).headlineSmall,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                MyButton(
                  child: Expanded(
                    child: Column(
                      children: List.generate(10, (index) {
                        return Center(
                          child: Text(
                            'CHF : ${(index * mult + 1) * 0.91}',
                            style: TextTheme.of(context).headlineSmall,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: .center,
//           children: [
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
