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

  final size = 3;

  List<List<StateCase>> board = [
    for (int row = 0; row < 3; row++ ) [
      for(int col = 0; col < 3; col++)
        StateCase.empty
      ]
    ];

  bool firstPlayer = true;

  void isWinner(){

    print(board);

    StateCase player;
    if (firstPlayer){
      player = StateCase.cross;
    } else {
      player = StateCase.circle;
    }
    
    var rowWin = false;

    for(int row = 0; row < size; row++ ){
      rowWin = checkRow(row, 0, player, 0);
      if (rowWin){
        break;
      }
    }

    var colWin = false;

    for(int col = 0; col < size; col++ ){
      colWin = checkCol(0, col, player, 0);
      if (colWin){
        break;
      }
    }

   
    
    var diagWing;
    var reverseDiagWin;

    if(rowWin || colWin){
      getWinningPlayer();
    }


  }

  bool checkRow(int row, int col, StateCase player, int counter){

    if (col > size ){
      return false;
    }

    if(counter == size){
      return true;
    }

    if (player == board[row][col]){
      counter++;
      col++;
      return checkRow(row, col, player, counter);
    }
    
    return false;
  }
  
  bool checkCol(int row, int col, StateCase player, int counter){
    
    if (row > size ){
      return false;
    }

    if(counter == size){
      return true;
    }

    if (player.placeOlder == board[row][col].placeOlder){
      counter++;
      row++;
      return checkCol(row, col, player, counter);
    }

    return false;
  }

  void getWinningPlayer(){
    if (firstPlayer){
      print("Joueur 1 à gagné"); 
    } else {
      print("Joueur 2 à gagné");
    }
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
                          isWinner();
                          firstPlayer = !firstPlayer;
                        } else {
                          board[i][j] = StateCase.circle;
                          isWinner();
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