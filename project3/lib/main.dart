import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';


import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'overlay_main.dart';
import 'game.dart';
import 'overlay_pause.dart';
import 'settings_page.dart';
import 'overlay_upgrades.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  runApp(
    ChangeNotifierProvider(
      create: (context)=>GameProvider(),
      child: const MainApp(),
    )
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  int _currentNavScreen=0;

  final List<Widget> _bottomNavScreens=[
    const MainGame(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Project 3 Game"),
          backgroundColor: Colors.grey,
        ),
        body: IndexedStack(
          index: _currentNavScreen,
          children: _bottomNavScreens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentNavScreen,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings"
            )
          ],
          onTap: (value){
            setState(() {
              _currentNavScreen=value;
            });
          },
        ),
      ),


    );
  }
}


class MainGame extends StatefulWidget {
  const MainGame({super.key});

  @override
  State<MainGame> createState() => _MainGameState();
}

class _MainGameState extends State<MainGame> {
  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context,listen:false);

    return GameWidget.controlled(
      gameFactory: () {
        final game = OverlayTutorial(context);
        game.paused = true;
        gameProvider.game = game;
        return game;
      },
      overlayBuilderMap: {
        'main': (context, game) => mainOverlay(context, game),
        'pause': (context, game) => pauseOverlay(context, game),
        'upgrades':(context,game)=>upgradesOverlay(context, game)
      },
      initialActiveOverlays: const ['main'],
    );

  }
}

