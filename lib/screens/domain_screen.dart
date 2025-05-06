import 'package:agahi/consts/screen_types.dart';
import 'package:agahi/screens/domain_specific/agriculture.dart';
import 'package:agahi/screens/domain_specific/education.dart';
import 'package:agahi/screens/domain_specific/health.dart';
import 'package:flutter/material.dart';

class DomainScreen extends StatelessWidget {
  final ScreenType screenType;
  final String imagePath;
  const DomainScreen({
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // AppBarWidget(),
            // const SizedBox(height: 20),

            // Align(
            //   alignment: Alignment.center,
            //   child: Hero(
            //     tag: screenType,

            //     child: Container(
            //       width: 200,
            //       height: 200,

            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: Colors.white,
            //       ),
            //       child: Image.asset(imagePath, fit: BoxFit.cover),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 50),
            ListViewFor(screenType: screenType, imagePath: imagePath),

            const SizedBox(height: 20),

            Spacer(),
          ],
        ),
      ),
    );
  }
}

class ListViewFor extends StatelessWidget {
  final ScreenType screenType;
  final String imagePath;

  const ListViewFor({
    super.key,
    required this.screenType,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Text(
            //   'Explore ${screenType.toString().split('.').last}',
            //   style: const TextStyle(
            //     fontSize: 24,
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),

            //colum widget for respective screen type
            if (screenType == ScreenType.education) EducationListView(),
            if (screenType == ScreenType.agriculture) AgricultureListView(),
            // if (screenType == ScreenType.economy) EconomyListView(),
            if (screenType == ScreenType.health) HealthListView(),
          ],
        ),
      ),
    );
  }
}
