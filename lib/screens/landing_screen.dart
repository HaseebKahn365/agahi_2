import 'package:flutter/material.dart';

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
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.logout, color: Colors.white, size: 30),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                _buildImageButton('assets/images/edu.jpg'),
                _buildImageButton('assets/images/agri.jpg'),
                _buildImageButton('assets/images/ecom.jpg'),
                _buildImageButton('assets/images/health.jpg'),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/speakoff.png',
                  width: 60,
                  height: 60,
                ),
                SizedBox(width: 40),
                Image.asset('assets/images/speakon.png', width: 60, height: 60),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageButton(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }
}
