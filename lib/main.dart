import 'dart:async';
import 'dart:developer';

import 'package:agahi/l10n/tts_helper_provider.dart';
import 'package:agahi/language_support/sentences.dart';
import 'package:agahi/screens/ecom/ecom_provider.dart';
import 'package:agahi/screens/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TtsHelper().initialize();

  runApp(
    //using ChangeNotifierProvider to provide the language settings
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => TtsHelper()),
        ChangeNotifierProvider(create: (context) => ShoppingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ShoppingProvider>(
      context,
      listen: false,
    ).loadItems(); // Load shopping items from SharedPreferences
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        final isUrdu = languageProvider.isUrdu;
        // final locale = isUrdu ? const Locale('ur') : const Locale('ps');
        final title = isUrdu ? Sentences.welcomeUrdu : Sentences.welcomePashto;

        return MaterialApp(
          title: title,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.indigo,
          ),
          // supportedLocales: L10n.all,
          // locale: locale,
          // localizationsDelegates: [
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          // home: MyHomePage(title: title),
          home: const LandingScreen(), // Use SplashScreen as the initial screen
        );
      },
    );
  }
}

//creating a splash screen that contains a Center image as logo.png and a progress indicator below it.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Auto navigate to MyHomePage after 3 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'Welcome'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 20),
            const SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                minHeight: 10,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Loading...', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    bool isUrdu = Provider.of<LanguageProvider>(context).isUrdu;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //A BIGGER APP NAME TEXT
            Text(
              isUrdu ? Sentences.appNameUrdu : Sentences.appNamePashto,
              style: const TextStyle(fontSize: 55, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 32),
            Text(
              title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 64),
            //toggle coontainers
            ToggleContainers(),

            //next button
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// A pair of containers to toggle between Urdu and Pashto, styled for better UX
class ToggleContainers extends StatefulWidget {
  const ToggleContainers({super.key});

  @override
  _ToggleContainersState createState() => _ToggleContainersState();
}

class _ToggleContainersState extends State<ToggleContainers> {
  bool _isUrdu = true;

  // Timer for debouncing navigation
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _debounceTimer = null; // Clear the timer reference
    super.dispose();
  }

  // Navigate with debounce - cancels previous timer if language is changed
  void navigateWithDebounce() {
    // Cancel existing timer if there's one running
    _debounceTimer?.cancel();
    log('debounce timer cancelled');

    // Create new timer
    _debounceTimer = Timer(const Duration(seconds: 1), () {
      log('debounce timer executed');

      if (mounted) {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) =>
                    const LandingScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(
                begin: begin,
                end: end,
              ).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LanguageProvider>(context).isUrdu = _isUrdu;
    // Speak the selected language when toggled
    if (_isUrdu) {
      TtsHelper().speakUrdu(Sentences.selectedLanguageUrdu);
    } else {
      TtsHelper().speakPashto(Sentences.selectedLanguagePashto);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildToggleButton(
            label: 'اردو',
            selected: _isUrdu,
            onTap: () {
              setState(() {
                _isUrdu = true;
                Provider.of<LanguageProvider>(
                  context,
                  listen: false,
                ).changeLanguage(true);

                //navigate with debounce
                navigateWithDebounce();
              });
            },
          ),
          const SizedBox(width: 16),
          _buildToggleButton(
            label: 'پښتو',
            selected: !_isUrdu,
            forUrdu: false,

            onTap: () {
              setState(() {
                _isUrdu = false;
                Provider.of<LanguageProvider>(
                  context,
                  listen: false,
                ).changeLanguage(false);
                navigateWithDebounce();
              });
            },
          ),
        ],
      ),
    );
  }

  //for urdu.green[400]! should be the color, for pashto it should be red. if not selected then only outline else fill the color

  Widget _buildToggleButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    bool forUrdu = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: 120,
        height: 120,
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          color:
              selected
                  ? (forUrdu ? Colors.green[400]! : Colors.red[200]!)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          boxShadow:
              selected
                  ? [
                    BoxShadow(
                      color: forUrdu ? Colors.green[400]! : Colors.red[200]!,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : [],
          border: Border.all(
            color:
                selected
                    ? (forUrdu ? Colors.green[400]! : Colors.red[200]!)
                    : forUrdu
                    ? Colors.green[400]!
                    : Colors.red[200]!,
            width: 8,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoNaskhArabic',
              ),
            ),

            const SizedBox(height: 8),
            selected
                ? Icon(Icons.check_circle, color: Colors.white, size: 40)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
