import 'package:agahi/consts/screen_types.dart';
import 'package:agahi/l10n/tts_helper_provider.dart';
import 'package:agahi/screens/domain_screen.dart';
import 'package:agahi/screens/ecom/ecom_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F2F4F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarWidget(),
            SizedBox(height: 20),
            GridView.count(
              //turn off scroll
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                _buildImageButton('assets/images/edu.png', context),
                _buildImageButton('assets/images/agri.png', context),
                _buildImageButton('assets/images/ecom.png', context),
                _buildImageButton('assets/images/health.png', context),
              ],
            ),
            Spacer(),
            Hero(tag: 'voiceToggle', child: VoiceToggleWidget()),
          ],
        ),
      ),
    );
  }

  Widget _buildImageButton(String imagePath, BuildContext context) {
    var selectedScreenType = ScreenType.education; // Default screen type
    switch (imagePath) {
      case 'assets/images/edu.png':
        selectedScreenType = ScreenType.education;
        break;
      case 'assets/images/agri.png':
        selectedScreenType = ScreenType.agriculture;
        break;
      case 'assets/images/ecom.png':
        selectedScreenType = ScreenType.economy;
        break;
      case 'assets/images/health.png':
        selectedScreenType = ScreenType.health;
        break;
    }

    void navigateToScreen(selectedScreenType, String imagePath) {
      // Implement your navigation logic here

      //if ecommerce image is clicked, navigate to ecommerce screen without going to domain screen
      if (imagePath == 'assets/images/ecom.png') {
        // Navigate directly to the ecommerce screen
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) => ShoppingScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(
                begin: begin,
                end: end,
              ).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => DomainScreen(
                screenType: selectedScreenType,
                imagePath: imagePath,
              ),
        ),
      );
    }

    return _ZoomButton(
      onTap: () {
        navigateToScreen(selectedScreenType, imagePath);
      },
      child: Hero(
        tag: selectedScreenType,
        child: Card(
          elevation: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),

            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Hero(
              tag: 'backButton',
              child: Align(
                alignment: Alignment.topLeft,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: const Icon(
                        Icons.subdirectory_arrow_left,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // a button to toggle voice on and off
            const Spacer(),
            Hero(
              tag: 'voiceToggle',
              child: Consumer<TtsHelper>(
                builder: (context, ttsHelper, child) {
                  return GestureDetector(
                    onTap: () {
                      ttsHelper.toggleVoiceOnOff();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      child: Icon(
                        ttsHelper.isVoiceOn
                            ? Icons.volume_up
                            : Icons.volume_off,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class VoiceToggleWidget extends StatelessWidget {
  const VoiceToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TtsHelper>(
      builder: (context, ttsHelper, child) {
        return Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: GestureDetector(
            onTap: () {
              ttsHelper.toggleVoiceOnOff();
            },
            // child: Stack(
            //   fit: StackFit.expand,
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.all(5),
            //       child: Image.asset(
            //         'assets/images/speakon.png',
            //         fit: BoxFit.contain,
            //       ),
            //     ),
            //     if (!ttsHelper.isVoiceOn)

            //   ],
            // ),
          ),
        );
      },
    );
  }
}

class _ZoomButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  const _ZoomButton({required this.child, required this.onTap});

  @override
  State<_ZoomButton> createState() => _ZoomButtonState();
}

class _ZoomButtonState extends State<_ZoomButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _scale = 0.92;
        });
      },
      onTapUp: (details) {
        setState(() {
          _scale = 1.0;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          _scale = 1.0;
        });
      },
      child: AnimatedScale(
        scale: _scale,
        duration:
            _scale < 1.0
                ? Duration(microseconds: 1) // Quick on tap down
                : Duration(milliseconds: 300), // Slower on tap up/cancel
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
