import 'package:flutter/material.dart';


class MyGrid extends StatelessWidget {
  const MyGrid({super.key});

  @override
  Widget build(BuildContext context){


    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            for (int i = 0; i < 3; i++)
              Row(
                mainAxisAlignment: .center,
                children: [
                  for (int i = 0; i < 3; i++)
                  Container(
                    decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Color.fromARGB(255, 1, 0, 0)),
                      right: BorderSide(color: Color.fromARGB(255, 1, 0, 0)),
                      top: BorderSide(color: Color.fromARGB(255, 1, 0, 0)),
                      bottom: BorderSide(color: Color.fromARGB(255, 1, 0, 0)),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Text(""),
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