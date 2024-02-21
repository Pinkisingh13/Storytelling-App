import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storytelling_app/screens/carousel_slider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: Image.asset(
                "assets/images/logo.png",
                height: 100,
                width: 100,
              ),
              onTap: () => Navigator.pushReplacement(
                context,
                PageTransition(
                  child: const StartScreen(),
                  type: PageTransitionType.scale,
                  alignment: Alignment.bottomCenter,
                  duration: const Duration(milliseconds: 1600),
                  reverseDuration: const Duration(milliseconds: 1600),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "AIYO",
              style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
