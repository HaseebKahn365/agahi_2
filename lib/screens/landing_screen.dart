import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

//New plan:
/*
lets first convert the landing screen to carousel 

 */

//at the top there should be 4 segmented buttons to controll the carousel. all in alphabetical order
// 1. Agriculture
// 2. Economy
// 3. Education
// 4. Health

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;
  String selectedSegment = 'Agriculture';
  int currentIndex = 0;
  final _carouselController = CarouselSliderController();
  // Add a ScrollController to control scrolling
  final ScrollController _scrollController = ScrollController();

  final List<String> _domains = [
    'assets/images/agri.png',
    'assets/images/ecom.png',
    'assets/images/edu.png',
    'assets/images/health.png',
  ];

  bool isSecondLevelOpened = false;

  @override
  void dispose() {
    // Dispose the scroll controller when the widget is disposed
    _scrollController.dispose();
    super.dispose();
  }

  // Method to smoothly scroll to the bottom
  void _scrollToBottom() {
    setState(() {
      isSecondLevelOpened = false;
    });
    isSecondLevelOpened = true;
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1200),
        curve: Curves.easeOutQuint,
      );
    });
  }

  //scroll to top and close the second level
  void _scrollToTop() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuint,
    );
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        isSecondLevelOpened = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          controller: _scrollController, // Add the scroll controller here
          physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Container(
                color: const Color(0xFF2F2F4F),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  spacing: 40,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          isSelected: List.generate(
                            4,
                            (index) => _currentIndex == index,
                          ),
                          onPressed: (index) {
                            setState(() {
                              _currentIndex = index;
                              _carouselController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 800),
                                curve: Curves.easeInOutCubic,
                              );
                            });
                          },
                          borderRadius: BorderRadius.circular(12),
                          selectedColor: Colors.white,
                          fillColor: Colors.blue,
                          color: Colors.grey,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('Agriculture'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('Economy'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('Education'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('Health'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CarouselSlider.builder(
                      carouselController: _carouselController,
                      itemCount: _domains.length,
                      options: CarouselOptions(
                        height: 400,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.easeInOutCubic,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: const Duration(
                          milliseconds: 1500,
                        ),
                        viewportFraction: 0.7,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              // If the second level is now open, scroll to it
                              _scrollToBottom();
                            });
                          },
                          child: Hero(
                            tag: _domains[index],
                            child: Card(
                              elevation: 10,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  _domains[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 150),
                    if (isSecondLevelOpened) buildCarousel(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildCarousel() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              padding: const EdgeInsets.all(20),
              icon: Image.asset('assets/images/up.png', width: 80, height: 80),
              onPressed: () {
                setState(() {
                  // isSecondLevelOpened = false;
                  _scrollToTop();
                  Future.delayed(const Duration(milliseconds: 100), () {
                    isSecondLevelOpened = false;
                  });
                });
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/forward.png',
                width: 80,
                height: 80,
              ),
              onPressed: () {
                // Navigate to the next screen or perform any action
              },
            ),
          ],
        ),
        CarouselSlider.builder(
              itemCount: 4,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Item $index',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 400,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.easeInOutCubic,
                autoPlayAnimationDuration: Duration(milliseconds: 1200),
                viewportFraction: 0.8,
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeOutCubic)
            .move(
              begin: const Offset(0, 0.1),
              end: const Offset(0, 0),
              duration: 800.ms,
              curve: Curves.easeInOutCubic,
            )
            .scale(begin: const Offset(0.9, 0.9), curve: Curves.easeInOutCubic),
        const SizedBox(height: 200),
      ],
    );
  }
}

// class LandingScreen extends StatelessWidget {
//   const LandingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF2F2F4F),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             AppBarWidget(),
//             SizedBox(height: 20),
//             GridView.count(
//               //turn off scroll
//               physics: NeverScrollableScrollPhysics(),
//               crossAxisCount: 2,
//               shrinkWrap: true,
//               mainAxisSpacing: 20,
//               crossAxisSpacing: 20,
//               children: [
//                 _buildImageButton('assets/images/edu.png', context),
//                 _buildImageButton('assets/images/agri.png', context),
//                 _buildImageButton('assets/images/ecom.png', context),
//                 _buildImageButton('assets/images/health.png', context),
//               ],
//             ),
//             Spacer(),
//             Hero(tag: 'voiceToggle', child: VoiceToggleWidget()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImageButton(String imagePath, BuildContext context) {
//     var selectedScreenType = ScreenType.education; // Default screen type
//     switch (imagePath) {
//       case 'assets/images/edu.png':
//         selectedScreenType = ScreenType.education;
//         break;
//       case 'assets/images/agri.png':
//         selectedScreenType = ScreenType.agriculture;
//         break;
//       case 'assets/images/ecom.png':
//         selectedScreenType = ScreenType.economy;
//         break;
//       case 'assets/images/health.png':
//         selectedScreenType = ScreenType.health;
//         break;
//     }

//     void navigateToScreen(selectedScreenType, String imagePath) {
//       // Implement your navigation logic here

//       //if ecommerce image is clicked, navigate to ecommerce screen without going to domain screen
//       if (imagePath == 'assets/images/ecom.png') {
//         // Navigate directly to the ecommerce screen
//         Navigator.push(
//           context,
//           PageRouteBuilder(
//             pageBuilder:
//                 (context, animation, secondaryAnimation) => ShoppingScreen(),
//             transitionsBuilder: (
//               context,
//               animation,
//               secondaryAnimation,
//               child,
//             ) {
//               const begin = Offset(0.0, 1.0);
//               const end = Offset.zero;
//               const curve = Curves.easeInOut;

//               var tween = Tween(
//                 begin: begin,
//                 end: end,
//               ).chain(CurveTween(curve: curve));
//               var offsetAnimation = animation.drive(tween);

//               return SlideTransition(position: offsetAnimation, child: child);
//             },
//           ),
//         );
//         return;
//       }
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder:
//               (context) => DomainScreen(
//                 screenType: selectedScreenType,
//                 imagePath: imagePath,
//               ),
//         ),
//       );
//     }

//     return _ZoomButton(
//       onTap: () {
//         navigateToScreen(selectedScreenType, imagePath);
//       },
//       child: Hero(
//         tag: selectedScreenType,
//         child: Card(
//           elevation: 10,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),

//             child: Image.asset(imagePath, fit: BoxFit.cover),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AppBarWidget extends StatelessWidget {
//   const AppBarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 20),
//         Row(
//           children: [
//             Hero(
//               tag: 'backButton',
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     onTap: () => Navigator.of(context).pop(),
//                     borderRadius: BorderRadius.circular(50),
//                     child: Container(
//                       padding: const EdgeInsets.all(15),
//                       child: const Icon(
//                         Icons.subdirectory_arrow_left,
//                         color: Colors.white,
//                         size: 60,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             // a button to toggle voice on and off
//             const Spacer(),
//             Hero(
//               tag: 'voiceToggle',
//               child: Consumer<TtsHelper>(
//                 builder: (context, ttsHelper, child) {
//                   return GestureDetector(
//                     onTap: () {
//                       ttsHelper.toggleVoiceOnOff();
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(15),
//                       child: Icon(
//                         ttsHelper.isVoiceOn
//                             ? Icons.volume_up
//                             : Icons.volume_off,
//                         color: Colors.white,
//                         size: 60,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class VoiceToggleWidget extends StatelessWidget {
//   const VoiceToggleWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TtsHelper>(
//       builder: (context, ttsHelper, child) {
//         return Container(
//           height: 100,
//           width: 100,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//           child: GestureDetector(
//             onTap: () {
//               ttsHelper.toggleVoiceOnOff();
//             },
//             // child: Stack(
//             //   fit: StackFit.expand,
//             //   children: [
//             //     Container(
//             //       padding: const EdgeInsets.all(5),
//             //       child: Image.asset(
//             //         'assets/images/speakon.png',
//             //         fit: BoxFit.contain,
//             //       ),
//             //     ),
//             //     if (!ttsHelper.isVoiceOn)

//             //   ],
//             // ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _ZoomButton extends StatefulWidget {
//   final VoidCallback onTap;
//   final Widget child;
//   const _ZoomButton({required this.child, required this.onTap});

//   @override
//   State<_ZoomButton> createState() => _ZoomButtonState();
// }

// class _ZoomButtonState extends State<_ZoomButton> {
//   double _scale = 1.0;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (details) {
//         setState(() {
//           _scale = 0.92;
//         });
//       },
//       onTapUp: (details) {
//         setState(() {
//           _scale = 1.0;
//         });
//         widget.onTap();
//       },
//       onTapCancel: () {
//         setState(() {
//           _scale = 1.0;
//         });
//       },
//       child: AnimatedScale(
//         scale: _scale,
//         duration:
//             _scale < 1.0
//                 ? Duration(microseconds: 1) // Quick on tap down
//                 : Duration(milliseconds: 300), // Slower on tap up/cancel
//         curve: Curves.easeOut,
//         child: widget.child,
//       ),
//     );
//   }
// }
