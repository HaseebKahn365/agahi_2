import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  await TtsHelper().initialize(); // Initialize TTS helper

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
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
            const SizedBox(height: 23), // Use SizedBox for spacing
            ElevatedButton(
              onPressed: () {
                // Speak a sentence in Urdu
                TtsHelper().speakAloud(
                  "یہ ایک ٹیسٹ جملہ ہے۔ یہ ایپلیکیشن اردو میں بول سکتی ہے۔",
                );
              },
              child: const Text('Speak Urdu'),
            ),
            //speak pashto
            ElevatedButton(
              onPressed: () {
                // Speak a sentence in Pashto
                TtsHelper().speakAloud(
                  "دا یوه ازموینې جمله ده. دا غوښتنلیک په پښتو کې خبرې کولی شي.",
                );
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

  final TextToSpeech _tts = TextToSpeech();
  bool _initialized = false;

  TtsHelper._internal();

  Future<void> initialize() async {
    if (!_initialized) {
      // Optionally set default settings here
      _initialized = true;
    }
  }

  Future<void> speakAloud(String sentence) async {
    if (!_initialized) {
      await initialize();
    }
    // Set language to Urdu (ur-PK)
    _tts.setLanguage('ur-PK');
    _tts.speak(sentence);
  }

  /// Speaks the given sentence in Pashto language.
  Future<void> speakPashto(String sentence) async {
    if (!_initialized) {
      await initialize();
    }
    // Set language to Pashto (ps-AF)
    _tts.setLanguage('ps-AF');
    _tts.speak(sentence);
  }

  Future<void> speakUrdu(String sentence) async {
    if (!_initialized) {
      await initialize();
    }

    _tts.setLanguage('ur-PK');
    _tts.speak(sentence);
  }
}
