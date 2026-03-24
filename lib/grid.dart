import 'dart:ffi';

import 'package:flutter/material.dart';

enum StateCase { 
  empty(placeOlder: ""),
  cross(placeOlder: "X"),
  circle(placeOlder: "O");
  
  const StateCase({
    required this.placeOlder
  });

  final String placeOlder;
}


class MyGrid extends StatefulWidget{

  const MyGrid({ super.key });

  @override
  State<StatefulWidget> createState() => _MyGridSate();

}

class _MyGridSate extends State<MyGrid> {

  List<List<StateCase>> board = [
    for (int row = 0; row < 3; row++ ) [
      for(int col = 0; col < 3; col++)
        StateCase.empty
      ]
    ];

  bool firstPlayer = true;
  
  


  void placePawn(int row, int col){
    
  }


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
                  for (int j = 0; j < 3; j++)
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (firstPlayer){
                          board[i][j] = StateCase.cross;
                          firstPlayer = !firstPlayer;
                        } else {
                          board[i][j] = StateCase.circle;
                          firstPlayer = !firstPlayer;
                        }
                      });
                    },
                    child: Stack(
                      alignment: AlignmentGeometry.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Color.fromARGB(255, 1, 0, 0)),
                            right: BorderSide(color: Color.fromARGB(255, 1, 0, 0)),
                            top: BorderSide(color: Color.fromARGB(255, 1, 0, 0)),
                            bottom: BorderSide(color: Color.fromARGB(255, 1, 0, 0)),
                            ),
                          ),
                          
                        ),
                        Text(board[i][j].placeOlder),
                      ],
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