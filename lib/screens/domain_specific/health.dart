import 'package:flutter/material.dart';

class HealthListView extends StatelessWidget {
  const HealthListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Add your health list items here
        displayImageButton('assets/images/health1.jpg', context),
        const SizedBox(height: 20),
        displayImageButton('assets/images/health2.jpg', context),
        const SizedBox(height: 20),
        displayImageButton('assets/images/health3.jpg', context),
      ],
    );
  }

  displayImageButton(String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (imagePath == 'assets/images/health1.jpg') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HealthSubjectScreen1()),
          );
        }

        if (imagePath == 'assets/images/health2.jpg') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HealthSubjectScreen2()),
          );
        }

        if (imagePath == 'assets/images/health3.jpg') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HealthSubjectScreen3()),
          );
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}

class HealthSubjectScreen1 extends StatelessWidget {
  const HealthSubjectScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              displayImageButton('assets/images/health1.jpg', context),
              const SizedBox(height: 20),
              displayImageButton('assets/images/health21.jpg', context),
              const SizedBox(height: 20),
              displayImageButton('assets/images/health22.jpg', context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  displayImageButton(String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement your navigation logic here
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}

class HealthSubjectScreen2 extends StatelessWidget {
  const HealthSubjectScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              displayImageButton('assets/images/health2.jpg', context),
              const SizedBox(height: 20),
              displayImageButton('assets/images/health22.jpg', context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  displayImageButton(String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement your navigation logic here
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}

class HealthSubjectScreen3 extends StatelessWidget {
  const HealthSubjectScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              displayImageButton('assets/images/health3.jpg', context),
              const SizedBox(height: 20),
              displayImageButton('assets/images/health4.jpg', context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  displayImageButton(String imagePath, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Implement your navigation logic here
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}
