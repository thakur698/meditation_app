import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  bool isPlaying = false;

  Future<void> playAudio(String path) async {
    await _player.play(AssetSource(path));

    isPlaying = true;
    notifyListeners();
  }

  Future<void> pauseAudio() async {
    await _player.pause();

    isPlaying = false;
    notifyListeners();
  }

  Future<void> stopAudio() async {
    await _player.stop();

    isPlaying = false;
    notifyListeners();
  }
}
