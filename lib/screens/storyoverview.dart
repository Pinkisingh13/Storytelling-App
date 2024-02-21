import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storytelling_app/models/storymodel.dart';
import 'package:storytelling_app/widget/fullstory.dart';

class StoryOverView extends StatelessWidget {
  const StoryOverView({super.key, required this.story});
  final StoryBodyModel story;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Story Overview",
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 24,
            color: Color.fromARGB(255, 88, 83, 87),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 700,
          margin: const EdgeInsets.only(top: 30, left: 20),
          // color: Colors.green,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: story.image,
                height: 292,
                width: 320,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                story.title,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                // textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                story.time,
                style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                story.discription,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                softWrap: true,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: FullStory(story: story),
                      type: PageTransitionType.leftToRightWithFade,
                      alignment: Alignment.bottomCenter,
                      duration: const Duration(milliseconds: 500),
                      reverseDuration: const Duration(milliseconds: 500),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(320, 48),
                ),
                child: Text(
                  "Start Reading",
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
