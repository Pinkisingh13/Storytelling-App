import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storytelling_app/data/data.dart';
import 'package:storytelling_app/models/storymodel.dart';
import 'package:storytelling_app/screens/whathappennext_screen.dart';

class FullStory extends StatefulWidget {
  const FullStory({super.key, required this.story});
  final StoryBodyModel story;

  @override
  State<FullStory> createState() => _FullStoryState();
}

class _FullStoryState extends State<FullStory> {
  late final StoryBodyModel story;
  var currentPageIndex = 1;
  final fullLength = fullStoryData.length;

  @override
  void initState() {
    super.initState();
    story = widget.story;
  }

  void pageIndex() {
    if (currentPageIndex < fullLength - 1) {
      setState(() {
        currentPageIndex++;
      });
    } else {
      showModalBottomSheet(
        isDismissible: true,
        useSafeArea: true,
        isScrollControlled: true,
        backgroundColor: Colors.black,
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Container(
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Thank You For Reading",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 23),
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

  void backPage() {
    if (currentPageIndex > 1) {
      setState(() {
        currentPageIndex--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "page $currentPageIndex  of $fullLength ",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: backPage,
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              size: 24, color: Color.fromARGB(255, 88, 83, 87)),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          // height: 700,
          width: 380,

          margin: const EdgeInsets.only(top: 30, left: 20),

          // color: Colors.yellow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: story.image,
                fit: BoxFit.fill,
                height: 292,
                alignment: Alignment.centerLeft,
                width: 350,
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  story.title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                fullStoryData[currentPageIndex].discription,
                style: GoogleFonts.poppins(
                    color: Colors.white, fontSize: 12, height: 2),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: pageIndex,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(320, 48),
                ),
                child: Text(
                  "Next Page",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const WhatHappen(),
                      type: PageTransitionType.size,
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
                  "Choose what happen next",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
