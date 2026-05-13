import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  late final AudioPlayer _audioPlayer;

  AudioService._internal() {
    _audioPlayer = AudioPlayer();
  }

  factory AudioService() {
    return _instance;
  }

  /// Play correct answer sound
  Future<void> playCorrectSound() async {
    try {
      await _audioPlayer.stop();
      // Using a free online correct sound
      await _audioPlayer.play(
        UrlSource(
          'https://assets.mixkit.co/active_storage/sfx/2869/2869-preview.mp3',
        ),
      );
    } catch (e) {
      print('Error playing correct sound: $e');
    }
  }

  /// Play incorrect answer sound
  Future<void> playIncorrectSound() async {
    try {
      await _audioPlayer.stop();
      // Using a free online incorrect sound
      await _audioPlayer.play(
        UrlSource(
          'https://assets.mixkit.co/active_storage/sfx/2867/2867-preview.mp3',
        ),
      );
    } catch (e) {
      print('Error playing incorrect sound: $e');
    }
  }

  /// Play button click sound
  Future<void> playClickSound() async {
    try {
      await _audioPlayer.stop();
      // Using a free online click sound
      await _audioPlayer.play(
        UrlSource(
          'https://assets.mixkit.co/active_storage/sfx/2571/2571-preview.mp3',
        ),
      );
    } catch (e) {
      print('Error playing click sound: $e');
    }
  }

  /// Play success/completion sound
  Future<void> playSuccessSound() async {
    try {
      await _audioPlayer.stop();
      // Using a free online success sound
      await _audioPlayer.play(
        UrlSource(
          'https://assets.mixkit.co/active_storage/sfx/2959/2959-preview.mp3',
        ),
      );
    } catch (e) {
      print('Error playing success sound: $e');
    }
  }

  /// Stop current audio
  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }

  /// Dispose audio player
  Future<void> dispose() async {
    try {
      await _audioPlayer.dispose();
    } catch (e) {
      print('Error disposing audio player: $e');
    }
  }

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    try {
      await _audioPlayer.setVolume(volume);
    } catch (e) {
      print('Error setting volume: $e');
    }
  }
}
