import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'game.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context, listen: true);
    final game=gameProvider.game;
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Settings",
            style: TextStyle(color: Colors.black, fontSize: 48),
          ),
          const SizedBox(height: 20),

          // Music volume slider
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.music_note),
              ),
              Expanded(
                child: Slider(
                  value: gameProvider.musicVolume,
                  min: 0,
                  max: 100,
                  divisions: 5,
                  label: gameProvider.musicVolume.toStringAsFixed(
                    1,
                  ), // Show value as "0.5"
                  onChanged: (value) {
                    gameProvider.setMusicVolume(value); // Update provider
                  },
                ),
              ),
            ],
          ),

          // Sound effects volume slider
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.volume_up),
              ),
              Expanded(
                child: Slider(
                  value: gameProvider.sfxVolume,
                  min: 0.0,
                  max: 1.0,
                  divisions: 5,
                  label: gameProvider.sfxVolume.toStringAsFixed(1),
                  onChanged: (value) {
                    gameProvider.setSfxVolume(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
