import 'package:flutter/material.dart';
import 'board_tile.dart';
import 'enums.dart';
import 'models/chunk.dart';

void main() {
  runApp(MaterialApp(
      home:MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final  _boardState = List.filled(9, TileState.empty);

    var _currentTurn = TileState.cross;

  Widget buildBoard(){
    return Builder(builder: (context){
      double boardDimension = MediaQuery.sizeOf(context).width / 3;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: chunk(_boardState, 3).asMap().entries.map((entry) {

          final chunkIndex = entry.key;
          final tileStateChunk = entry.value;

          return Row(
              children: tileStateChunk.asMap().entries.map((innerEntry) {
                final innerIndex = innerEntry.key;
                final tileState = innerEntry.value;
                final tileIndex = (chunkIndex * 3 ) + innerIndex;

                return BoardTile(
                  boardSize: boardDimension,
                  state: tileState,
                  onPress: () => _updateTileStateIndex(tileIndex),
                );
              }).toList()
          );

        }).toList(),
      );
    });
  }

  _updateTileStateIndex(int index){

    if(_boardState[index] == TileState.empty){
      setState(() {
        _boardState[index] = _currentTurn;
        _currentTurn = _currentTurn == TileState.cross ? TileState.circle: TileState.cross;
      });
      final winner = _finaWinner();
      if(winner != TileState.empty){
        print("Winner is: $winner");
        _showWinnerDialog(winner);
      }
    }

  }

  TileState _finaWinner(){
    winnerForMatch(a,b,c){
      if(_boardState[a] != TileState.empty){
        if((_boardState[a] == _boardState[b]) &&
            (_boardState[b] == _boardState[c])){
          return _boardState[a];
        }
      }
      return TileState.empty;
    }

    final checks = [
      winnerForMatch(0, 1, 2),
      winnerForMatch(3, 4, 5),
      winnerForMatch(6, 7, 8),
      winnerForMatch(0, 3, 6),
      winnerForMatch(1, 4, 7),
      winnerForMatch(2, 5, 8),
      winnerForMatch(0, 4, 8),
       winnerForMatch(2,4, 6),
    ];
  TileState winner = TileState.empty;
  for(int i = 0; i < checks.length; i++){
    if(checks[i] != TileState.empty){
      winner = checks[i];
      break;
    }
  }
  return winner;
  }

  _showWinnerDialog(TileState tileState){
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Winner", style: TextStyle(fontSize: 30),),
            content: Image.asset(
              (tileState == TileState.cross? 'images/x.png' :'images/o.png')),
            actions: [
              TextButton(onPressed: (){}, child: Text("Restart")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          body:Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('images/board.png'),
                buildBoard(),
              ],),
          )
      ),
    );
  }
}


