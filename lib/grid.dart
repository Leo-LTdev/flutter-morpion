import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/winnner.dart';

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

  bool isWinner(){

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
    
    var diagWin = false; 
    diagWin = checkDiag(0, 0, player, 0);

    var reverseDiagWin = false;
    reverseDiagWin = checkReverseDiag(2, 0, player, 0);



    if(rowWin || colWin || diagWin || reverseDiagWin){
      getWinningPlayer();
      return true;
    }

    return false;

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

  bool checkDiag(int row, int col, StateCase player, int counter){

    if (row > size ){
      return false;
    }

    if(counter == size){
      return true;
    }

    if (player.placeOlder == board[row][col].placeOlder){
      counter++;
      print(counter);
      row++;
      col++;
      return checkDiag(row, col, player, counter);
    }

    return false;
  }

  bool checkReverseDiag(int row, int col,StateCase player, int counter){

    if (row > size ){
      return false;
    }

    if(counter == size){
      return true;
    }

    if (player.placeOlder == board[row][col].placeOlder){
      counter++;
      row--;
      col++;
      return checkReverseDiag(row, col, player, counter);
    }

    return false;
  }

  String getWinningPlayer(){
    if (firstPlayer){
      return "Joueur 1 à gagné"; 
    } else {
      return "Joueur 2 à gagné"; 

    }
  }



  @override
  Widget build(BuildContext context){


    return Scaffold(
      backgroundColor: const Color(0xFF252C4A), // Un fond sombre moderne
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Tic Tac Toe",
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 3; i++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int j = 0; j < 3; j++)
                        GestureDetector(
                          onTap: () {
                            if (board[i][j] == StateCase.empty) { 
                              setState(() {
                                board[i][j] = firstPlayer ? StateCase.cross : StateCase.circle;
                                if (isWinner()){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => ResultPage(winner: getWinningPlayer())) 
                                  );
                                } else {
                                  firstPlayer = !firstPlayer;
                                }
                              });
                            }
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: j < 2 ? Colors.white24 : Colors.transparent, 
                                  width: 2,
                                ),
                                bottom: BorderSide(
                                  color: i < 2 ? Colors.white24 : Colors.transparent, 
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                board[i][j] == StateCase.cross ? "X" : (board[i][j] == StateCase.circle ? "O" : ""),
                                style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.w300,
                                  color: board[i][j] == StateCase.cross 
                                      ? const Color(0xFF64FFDA) // couleur X
                                      : const Color(0xFFFF5252), // couleur O
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 50),
            Text(
              firstPlayer ? "Tour de : X" : "Tour de : O",
              style: const TextStyle(color: Colors.white70, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}