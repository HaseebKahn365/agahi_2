import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsHelper extends ChangeNotifier {
  static final TtsHelper _instance = TtsHelper._internal();
  factory TtsHelper() => _instance;
  bool isVoiceOn = true; // Default voice state

  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;

  TtsHelper._internal();

  Future<void> initialize() async {
    if (!_initialized) {
      await _tts.setSpeechRate(0.5);
      await _tts.setVolume(1.0);
      await _tts.setPitch(0.9);
      _initialized = true;
    }
  }

  void toggleVoiceOnOff() {
    isVoiceOn = !isVoiceOn;
    notifyListeners();
  }

  Future<void> speakAloud(String sentence) async {
    if (!_initialized) {
      await initialize();
    }
    if (!isVoiceOn) return; // Don't speak if voice is off
    await _tts.setLanguage('ur-PK');
    await _tts.speak(sentence);
  }

  Future<void> speakPashto(String sentence) async {
    if (!_initialized) {
      await initialize();
    }
    if (!isVoiceOn) return; // Don't speak if voice is off
    await _tts.setLanguage('ps-AF');
    await _tts.speak(sentence);
  }

  Future<void> speakUrdu(String sentence) async {
    if (!_initialized) {
      await initialize();
    }
    if (!isVoiceOn) return; // Don't speak if voice is off
    await _tts.setLanguage('ur-PK');
    await _tts.speak(sentence);
  }
}

//provide for language settings

class LanguageProvider with ChangeNotifier {
  bool isUrdu = true; // Default language is Urdu

  changeLanguage(bool isUrdu) {
    this.isUrdu = isUrdu;
    notifyListeners();
  }
}
