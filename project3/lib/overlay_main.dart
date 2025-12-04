import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

Widget mainOverlay(BuildContext context, game) {
  final gameProvider = Provider.of<GameProvider>(context, listen: true);
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      color: Color.fromARGB(255, 255, 140, 9), // Semi-transparent orange
      width: double.infinity, // Full width
      height: 50,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // TODO: Pause
              game.paused = true;
              game.overlays.add('pause');
            },
            icon: Icon(Icons.pause),
          ),
          IconButton(
            onPressed: (){
              game.paused=true;
              game.overlays.add('upgrades');
            },
            icon:Icon(Icons.add_box)
          )
          
        ],
      ),
    ),
  );
}
