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
          home: MyHomePage(title: title),
        );
      },
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
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 64),
            //toggle coontainers
            ToggleContainers(),

            //next button
            const SizedBox(height: 32),

            GestureDetector(
              onTap: () {
                // Speak the selected language when the button is tapped
                // if (isUrdu) {
                //   TtsHelper().speakAloud(
                //     "${Sentences.appNameUrdu} ${Sentences.welcomeUrdu}",
                //   );
                // } else {
                //   TtsHelper().speakPashto(
                //     "${Sentences.appNamePashto} ${Sentences.welcomePashto}",
                //   );
                // }
              },
              child: GestureDetector(
                onTap: () {
                  //navigate to landing screen
                  Navigator.push(
                    context,
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
                        const curve = Curves.ease;
                        final tween = Tween(
                          begin: begin,
                          end: end,
                        ).chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.indigo, width: 2),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
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
