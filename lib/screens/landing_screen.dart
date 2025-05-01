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
            const SizedBox(height: 20),
            Hero(
              tag: 'logoutButton',
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white, size: 60),
                  onPressed: () {},
                ),
              ),
            ),
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
    ScreenType selectedScreenType;
    String label;

    // Determine screen type and label based on imagePath
    switch (imagePath) {
      case 'assets/images/edu.png':
        selectedScreenType = ScreenType.education;
        label = 'Education';
        break;
      case 'assets/images/agri.png':
        selectedScreenType = ScreenType.agriculture;
        label = 'Agriculture';
        break;
      case 'assets/images/ecom.png':
        selectedScreenType = ScreenType.economy;
        label = 'E-Commerce';
        break;
      case 'assets/images/health.png':
        selectedScreenType = ScreenType.health;
        label = 'Health';
        break;
      default:
        // Handle default case or throw an error if needed
        selectedScreenType = ScreenType.education; // Default fallback
        label = 'Unknown';
    }

    void navigateToScreen(ScreenType screenType, String imgPath) {
      // If ecommerce image is clicked, navigate to ecommerce screen directly
      if (imgPath == 'assets/images/ecom.png') {
        // Match the image path used in the GridView
        Navigator.push(
          context,
          PageRouteBuilder(
            // Ensure ShoppingScreen is imported and correct
            pageBuilder:
                (context, animation, secondaryAnimation) =>
                    const ShoppingScreen(), // Assuming ShoppingScreen exists
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
      } else {
        // Navigate to the generic DomainScreen for other types
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    DomainScreen(screenType: screenType, imagePath: imgPath),
          ),
        );
      }
    }

    // Use Card for a prominent button appearance
    return Card(
      elevation: 6.0, // Increased elevation for prominence
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Softer rounded corners
      ),
      clipBehavior: Clip.antiAlias, // Ensures content respects card boundaries
      child: InkWell(
        // Provides tap feedback (ripple effect)
        onTap: () => navigateToScreen(selectedScreenType, imagePath),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Stretch content horizontally
          children: <Widget>[
            Expanded(
              // Image takes up the available space above the label
              child: Hero(
                tag: selectedScreenType, // Unique tag for Hero animation
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover, // Cover the area nicely
                ),
              ),
            ),
            Container(
              // Container for label background and padding
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 8.0,
              ),
              color: Colors.black.withOpacity(
                0.6,
              ), // Semi-transparent background for label
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color:
                      Colors.white, // White text for contrast on dark overlay
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
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
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/images/speakon.png',
                    fit: BoxFit.contain,
                  ),
                ),
                if (!ttsHelper.isVoiceOn)
                  CustomPaint(painter: DiagonalLinePainter()),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DiagonalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5.0
          ..strokeCap = StrokeCap.round;

    // Draw a diagonal line from top-left to bottom-right
    canvas.drawLine(
      Offset(5, 5),
      Offset(size.width - 5, size.height - 5),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
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
