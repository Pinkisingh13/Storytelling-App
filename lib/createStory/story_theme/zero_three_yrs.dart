import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:storytelling_app/data/data.dart';
import 'package:storytelling_app/models/storymodel.dart';

class ZeroToThree extends StatefulWidget {
  const ZeroToThree({super.key, required this.id});

  final String id;
  @override
  State<ZeroToThree> createState() => _ZeroToThreeState();
}

class _ZeroToThreeState extends State<ZeroToThree> {
  @override
  Widget build(BuildContext context) {
    final zerotothree =
        storyThemeListener.where((e) => e.id.contains(widget.id)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 20),
          child: Text(
            'Pick a Story Theme',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 216, 216, 216),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 20),
          child: Text(
            'What kind of story are you in the mood for today?',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color.fromARGB(255, 157, 157, 157),
            ),
          ),
        ),
        GridView.builder(
          itemCount: zerotothree.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            return ZerotoThreeUi(
              story: zerotothree[index],
            );
          },
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            top: 25,
          ),
        ),
      ],
    );
  }
}

class ZerotoThreeUi extends StatelessWidget {
  const ZerotoThreeUi({super.key, required this.story});
  final StoryTheme story;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      // margin: ,
      color: Colors.red,
      width: 143,
      height: 155,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: story.image,
            fit: BoxFit.contain,
          ),
        
        ],
      ),
    );
  }
}
