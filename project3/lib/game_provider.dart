import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/game.dart';

class GameProvider extends ChangeNotifier {
  // Private variables for settings
  double _musicVolume = 1.0;
  double _sfxVolume = 1.0;

  bool _inGame = false;

  // Getters to access private variables
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;

  bool get inGame => _inGame;

  // Game reference
  FlameGame? _game;

  // Game reference getter
  FlameGame? get game => _game;

  // Audio players
  AudioPlayer musicPlayer = AudioPlayer();
  AudioPlayer sfxPlayer = AudioPlayer();

  // Audio context configuration - allows music to mix with SFX
  final AudioContext audioContext = AudioContextConfig(
    focus: AudioContextConfigFocus.mixWithOthers,
  ).build();

  // Setters with notifyListeners
  void setMusicVolume(double value) {
    _musicVolume = value;
    musicPlayer.setVolume(_musicVolume); // Apply volume to player
    notifyListeners();
  }

  void setSfxVolume(double value) {
    _sfxVolume = value;
    sfxPlayer.setVolume(_sfxVolume); // Apply volume to player
    notifyListeners();
  }

  // Game reference setter
  set game(FlameGame? value) {
    _game = value;
    // NO notifyListeners() here!
  }

  // Play background music
  Future<void> playBgm(String url) async {
    // Set audio context to allow mixing
    musicPlayer.setAudioContext(audioContext);

    // Set to loop when finished
    musicPlayer.setReleaseMode(ReleaseMode.loop);

    await musicPlayer.play(AssetSource(url));
  }

  // Play sound effect
  Future<void> playSfx(String url) async {
    await sfxPlayer.play(AssetSource(url));
  }

  @override
  void dispose() {
    print("Provider disposed");
    musicPlayer.dispose();
    sfxPlayer.dispose();
    super.dispose();
  }
}
