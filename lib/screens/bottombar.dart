import 'package:flutter/material.dart';
import 'package:storytelling_app/screens/home_screen.dart';
import 'package:storytelling_app/screens/profile.dart';
import 'package:storytelling_app/createStory/createstory.dart';
// import 'package:page_transition/page_transition.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;
  final pages = [
    const HomeScreen(),
    const Profile(),
    const CreateStory(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: pages[pageIndex],
        bottomNavigationBar: Container(
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon: pageIndex == 0
                    ? const Icon(
                        Icons.home_filled,
                        color: Colors.white,
                        size: 25,
                      )
                    : const Icon(
                        Icons.home_outlined,
                        color: Color.fromARGB(255, 86, 86, 86),
                        size: 25,
                      ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                icon: pageIndex == 1
                    ? const Icon(
                        Icons.person_rounded,
                        color: Colors.white,
                        size: 25,
                      )
                    : const Icon(
                        Icons.person_2_outlined,
                        color: Color.fromARGB(255, 86, 86, 86),
                        size: 25,
                      ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                icon: pageIndex == 2
                    ? const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 25,
                      )
                    : const Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 86, 86, 86),
                        size: 25,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
