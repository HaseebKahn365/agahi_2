import 'package:agahi/consts/screen_types.dart';
import 'package:agahi/main.dart';
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
                _buildImageButton('assets/images/edu.jpg', context),
                _buildImageButton('assets/images/agri.jpg', context),
                _buildImageButton('assets/images/ecom.jpg', context),
                _buildImageButton('assets/images/health.jpg', context),
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
      case 'assets/images/edu.jpg':
        selectedScreenType = ScreenType.education;
        break;
      case 'assets/images/agri.jpg':
        selectedScreenType = ScreenType.agriculture;
        break;
      case 'assets/images/ecom.jpg':
        selectedScreenType = ScreenType.economy;
        break;
      case 'assets/images/health.jpg':
        selectedScreenType = ScreenType.health;
        break;
    }

    void navigateToScreen(selectedScreenType, String imagePath) {
      // Implement your navigation logic here

      //if ecommerce image is clicked, navigate to ecommerce screen without going to domain screen
      if (imagePath == 'assets/images/ecom.jpg') {
        // Navigate directly to the ecommerce screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShoppingScreen()),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Hero(
          tag: selectedScreenType,

          child: Image.asset(imagePath, fit: BoxFit.cover),
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
