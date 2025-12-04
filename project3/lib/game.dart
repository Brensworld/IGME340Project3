import 'dart:async';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'game_provider.dart';




class OverlayTutorial extends FlameGame with TapCallbacks,WidgetsBindingObserver {
  final BuildContext context;
  late final GameProvider gameProvider;

  OverlayTutorial(this.context);

  @override
  Color backgroundColor() => const Color.fromARGB(248, 67, 65, 65);

  @override
  Future<void> onLoad() async {
    // Initialize provider
    gameProvider = Provider.of<GameProvider>(context, listen: true);
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    // Empty for now - we could add tap handling here
  }


  @override
  void onAttach() {
    super.onAttach();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onDispose() {
    print("Game disposed");
    WidgetsBinding.instance.removeObserver(this);
    gameProvider.dispose();
    super.onDispose();
  }
}