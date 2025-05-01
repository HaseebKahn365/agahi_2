import 'package:agahi/consts/screen_types.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class EducationListView extends StatefulWidget {
  const EducationListView({super.key});

  @override
  State<EducationListView> createState() => _EducationListViewState();
}

class _EducationListViewState extends State<EducationListView> {
  int _currentIndex = 0;
  final _carouselController = CarouselSliderController();
  final List<String> _educationImages = [
    'assets/images/edu1.png',
    'assets/images/edu2.png',
    'assets/images/edu3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: _educationImages.length,
          options: CarouselOptions(
            height: 400,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.7,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return displayImageButton(_educationImages[index], context);
          },
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              _educationImages.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 25.0,
                    height: 25.0,
                    margin: const EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white.withOpacity(
                        _currentIndex == entry.key ? 0.9 : 0.4,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${entry.key + 1}',
                        style: TextStyle(
                          color:
                              _currentIndex == entry.key
                                  ? Colors.black
                                  : Colors.grey[800],
                          fontWeight:
                              _currentIndex == entry.key
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget displayImageButton(String imagePath, BuildContext context) {
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
      child: Container(
        margin: const EdgeInsets.all(5.0),
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
    List<String> subjectImages = [
      'assets/images/edu11.jpg',
      'assets/images/edu11.jpg',
      'assets/images/edu11.jpg',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: CarouselSlider.builder(
          itemCount: subjectImages.length,
          options: CarouselOptions(
            height: 300,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(subjectImages[index], fit: BoxFit.cover),
            );
          },
        ),
      ),
    );
  }
}
