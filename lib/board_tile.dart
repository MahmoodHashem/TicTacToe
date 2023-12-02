
import 'package:flutter/material.dart';
import 'enums.dart';


class BoardTile extends StatelessWidget {
  const BoardTile({
    super.key,
    required this.boardSize, this.onPress, this.state = TileState.empty
  });

  final double boardSize;
  final Function()? onPress;
  final TileState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boardSize,
      height: boardSize,
      child: MaterialButton(
          onPressed: onPress,
          child: _widgetForTileState()
      ),
    );
  }

  Widget _widgetForTileState(){
    Widget widget;

    switch (state){
      case TileState.empty: widget = SizedBox();
      break;
      case TileState.cross: widget = Image.asset("images/x.png");
      break;
      case TileState.circle: widget = Image.asset("images/o.png");
    }
    return widget;
  }
}