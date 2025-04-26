import 'package:agahi/language_support/sentences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TtsHelper().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Agahi App'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Welcome to Agahi App!'),
            const SizedBox(height: 23),
            ElevatedButton(
              onPressed: () {
                TtsHelper().speakUrdu(Sentences.welcomeUrdu);
              },
              child: const Text('Speak Urdu'),
            ),
            ElevatedButton(
              onPressed: () {
                TtsHelper().speakAloud(Sentences.welcomePashto);
              },
              child: const Text('Speak Pashto'),
            ),
          ],
        ),
      ),
    );
  }
}

class TtsHelper {
  static final TtsHelper _instance = TtsHelper._internal();
  factory TtsHelper() => _instance;

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

  Future<void> speakAloud(String sentence) async {
    if (!_initialized) {
      await initialize();
    }
    await _tts.setLanguage('ur-PK');
    await _tts.speak(sentence);
  }

  Future<void> speakPashto(String sentence) async {
    if (!_initialized) {
      await initialize();
    }
    await _tts.setLanguage('ps-AF');
    await _tts.speak(sentence);
  }

  Future<void> speakUrdu(String sentence) async {
    if (!_initialized) {
      await initialize();
    }
    await _tts.setLanguage('ur-PK');
    await _tts.speak(sentence);
  }
}
