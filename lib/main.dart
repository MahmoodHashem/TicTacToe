import 'package:flutter/material.dart';
import 'board_tile.dart';
import 'enums.dart';
import 'models/chunk.dart';

void main() {
  runApp(MaterialApp(
      home:MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final  _boardState = List.filled(9, TileState.empty);

  @override
  Widget build(BuildContext context) {

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
                  );
                }).toList()
            );

          }).toList(),
        );
      });
    }

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


