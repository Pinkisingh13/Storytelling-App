import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storytelling_app/data/data.dart';
import 'package:storytelling_app/models/storymodel.dart';
import 'package:storytelling_app/provider/riverpod.dart';

class StoryBody extends ConsumerWidget {
  const StoryBody({super.key, required this.years});
  final YearsModel years;
 // using gridview
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final infoStory = ref.watch(bodyInformationProvider);
    final yearCategory =
        storyBodyData.where((story) => story.id.contains(years.id)).toList();
    return GridView.builder(
      itemBuilder: (context, index) {
        return StoryBodySubstitude(
            story: yearCategory[index],
            onStoryInformation: () {
              infoStory(context, yearCategory[index]);
            });
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 20,
      ),
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        top: 25,
      ),
      itemCount: yearCategory.length,
    );
  }
}

// Homescreen story container ui
class StoryBodySubstitude extends StatelessWidget {
  const StoryBodySubstitude(
      {super.key, required this.story, required this.onStoryInformation});

  final StoryBodyModel story;
  final void Function() onStoryInformation;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 365,
      width: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onStoryInformation,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              height: 152,
              width: 152,
              child: Stack(
                children: [
                  Image(
                    image: story.image,
                    height: 152,
                    width: 152,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 112,
                    child: Container(
                      height: 40,
                      width: 152,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 35, 35, 35),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 7),
                            child: Text(
                              story.title,
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 9),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              story.time,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
