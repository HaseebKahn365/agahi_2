import 'package:agahi/consts/screen_types.dart';
import 'package:flutter/material.dart';

class EducationListView extends StatelessWidget {
  const EducationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10,
        children: [
          // Add your education list items here
          //  show edu1 edu2 edu3 images
          displayImageButton('assets/images/edu1.png', context),
          const SizedBox(height: 20),
          displayImageButton('assets/images/edu2.png', context),
          const SizedBox(height: 20),
          displayImageButton('assets/images/edu3.png', context),
        ],
      ),
    );
  }

  displayImageButton(String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement your navigation logic here
        if (imagePath != 'assets/images/edu3.png') return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => EduSubjectScreen(
                  screenType: ScreenType.education,
                  imagePath: imagePath,
                ),
          ),
        );
      },
      child: SizedBox(
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class EduSubjectScreen extends StatelessWidget {
  final ScreenType screenType;
  final String imagePath;
  const EduSubjectScreen({
    super.key,
    required this.screenType,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  'assets/images/edu11.jpg',
                  fit: BoxFit.cover,
                ),
              ),

              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  'assets/images/edu11.jpg',
                  fit: BoxFit.cover,
                ),
              ),

              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  'assets/images/edu11.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
