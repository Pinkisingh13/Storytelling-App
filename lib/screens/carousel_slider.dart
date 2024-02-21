import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storytelling_app/data/data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:storytelling_app/provider/riverpod.dart';
import 'package:storytelling_app/screens/bottombar.dart';
import 'package:storytelling_app/screens/login_screen.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() {
    return StartScreenState();
  }
}

class StartScreenState extends ConsumerState<StartScreen> {
  void handleAuthentication() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (mounted) {
        if (user != null) {
          navigateToScreen(const BottomNavBar());
        } else {
          navigateToScreen(const Login());
        }
      }
    });
  }

  void navigateToScreen(Widget screen) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: screen,
        type: PageTransitionType.scale,
        alignment: Alignment.bottomCenter,
        duration: const Duration(milliseconds: 1600),
        reverseDuration: const Duration(milliseconds: 1600),
      ),
    );
  }

  CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentIndexProvider);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        // print(width);
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CarouselSlider(
                    carouselController: controller,
                    items: dummydata.map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 190,
                              width: 190,
                              child: e.image,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              height: 88,
                              width: 269,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    child: Text(
                                      e.title,
                                      style: GoogleFonts.poppins(
                                          color: const Color.fromRGBO(
                                              217, 217, 217, 0.9),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 269,
                                    child: Text(
                                      e.description,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                              255, 200, 199, 199),
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        ref.read(currentIndexProvider.notifier).state = index;
                      },
                      height: width < 600 || width > 1000 ? 500 : 400,
                      autoPlay: false,
                    ),
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: currentIndex,
                    count: dummydata.length,
                    textDirection: TextDirection.ltr,
                    axisDirection: Axis.horizontal,
                    effect: const SwapEffect(
                        dotColor: Colors.white,
                        activeDotColor: Colors.yellow,
                        dotHeight: 10,
                        dotWidth: 10,
                        paintStyle: PaintingStyle.fill,
                        type: SwapType.zRotation),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () => handleAuthentication(),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(320, 48),
                    ),
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: width > 600 ? 40 : 0,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
