import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:timelines/timelines.dart';
import 'package:horizontal_stepper_flutter/horizontal_stepper_flutter.dart';
import 'package:storytelling_app/createStory/story_theme/zero_three_yrs.dart';
import 'package:storytelling_app/screens/login_screen.dart';
// import 'package:storytelling_app/widget/secondstep.dart';
// import 'package:storytelling_app/widget/secondstep.dart';
// import 'package:storytelling_app/screens/startscreen.dart';

// class CreateStory extends StatefulWidget {
//   const CreateStory({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return _CreateStoryState();
//   }
// }

// class _CreateStoryState extends State<CreateStory>
//     with SingleTickerProviderStateMixin {
//   int currentStep = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_new_rounded,
//             size: 24,
//             color: Color.fromARGB(255, 88, 83, 87),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               // margin: const EdgeInsets.only(top: 30),
//               // color: Colors.green,
//               child: Theme(
//                 data: ThemeData(
//                   colorScheme: Theme.of(context).colorScheme.copyWith(
//                       background: Colors.black, primary: Colors.green),
//                 ),
//                 child: Stepper(
//                   margin: const EdgeInsets.only(right: 50),
//                   controlsBuilder: (context, details) {
//                     return const SizedBox.shrink();
//                   },
//                   elevation: 30,
//                   connectorColor: const MaterialStatePropertyAll(
//                     Colors.white,
//                   ),
//                   type: StepperType.horizontal,

//                   stepIconBuilder: (stepIndex, stepState) {
//                     return Image.asset(
//                       "assets/stepper/${stepIndex}_step.png",
//                       height: 15,
//                       width: 15,
//                     );
//                   },
//                   // connectorColor: MaterialStatePropertyAll(Colors.white),
//                   currentStep: currentStep,
//                   connectorThickness: 2,
//                   physics: const NeverScrollableScrollPhysics(),
//                   steps: [
//                     // First Step
//                     Step(
//                       state: StepState.complete,
//                       isActive: currentStep >= 0,
//                       label: Text(
//                         "Age",
//                         style: GoogleFonts.poppins(
//                             color: Colors.white, fontSize: 10),
//                       ),
//                       title: Container(
//                         width: 10,
//                         color: Colors.white,
//                         height: 2,
//                       ),
//                       content: FirstStep(currentStep: currentStep),
//                     ),
//                     Step(
//                       isActive: currentStep >= 1,
//                       label: const Text("Age"),
//                       title: Container(),
//                       content: Container(
//                         height: 30,
//                         width: 30,
//                         child: Text("no-2"),
//                       ),
//                     ),
//                     Step(
//                       isActive: currentStep >= 2,
//                       label: const Text("age"),
//                       title: Container(),
//                       content: Container(
//                         height: 30,
//                         width: 30,
//                         child: Text("0-3yrs old"),
//                       ),
//                     ),
//                     Step(
//                       isActive: currentStep >= 3,
//                       label: const Text("age"),
//                       title: Container(),
//                       content: Container(
//                         height: 30,
//                         width: 30,
//                         child: Text("0-3yrs old"),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class FirstStep extends StatefulWidget {
  const FirstStep({super.key, required this.onstepchange});

  final void Function(int count) onstepchange;
  @override
  State<FirstStep> createState() => _FirstStepState();
}

class _FirstStepState extends State<FirstStep> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset("assets/images/logo.png");
    if (count == 1) {
      image = Image.asset(
        "assets/stepper/0_3_years.png",
        height: 110,
        width: 110,
      );
    } else if (count == 2) {
      image = Image.asset(
        "assets/stepper/3_6_years.png",
        height: 110,
        width: 110,
      );
    } else if (count == 3) {
      image = Image.asset(
        "assets/stepper/6_12_years.png",
        height: 110,
        width: 110,
      );
    } else {
      image = Image.asset(
        "assets/stepper/young_at_heart.png",
        height: 110,
        width: 110,
      );
    }

    return Container(
      height: 500,
      // width: double.infinity,
      margin: const EdgeInsets.only(top: 30),
      // color: Colors.red,
      child: Column(
        children: [
          image,
          const SizedBox(
            height: 40,
          ),
          Text(
            "How old is the listener?",
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 36,
            width: 255,
            child: Text(
              "Select an age group, we'll craft the perfect story just for them!",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color.fromARGB(
                  255,
                  156,
                  156,
                  156,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    count = 1;
                  });
                  // widget.onstepchange(count);
                },
                style: count == 1
                    ? ElevatedButton.styleFrom(
                        minimumSize: const Size(122, 32),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      )
                    : ElevatedButton.styleFrom(
                        minimumSize: const Size(122, 32),
                        backgroundColor: const Color.fromARGB(255, 33, 33, 33),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                child: Text("0-3yrs old",
                    style: count == 1
                        ? GoogleFonts.poppins(
                            color: Colors.black,
                          )
                        : GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 164, 164, 164),
                          )),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    count = 2;
                  });
                  // widget.onstepchange(count);
                },
                style: count == 2
                    ? ElevatedButton.styleFrom(
                        minimumSize: const Size(122, 32),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      )
                    : ElevatedButton.styleFrom(
                        minimumSize: const Size(122, 32),
                        backgroundColor: const Color.fromARGB(255, 33, 33, 33),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                child: Text(
                  "3-6yrs old",
                  style: count == 2
                      ? GoogleFonts.poppins(
                          color: Colors.black,
                        )
                      : GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 164, 164, 164),
                        ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    count = 3;
                  });
                  // widget.onstepchange(count);
                },
                style: count == 3
                    ? ElevatedButton.styleFrom(
                        minimumSize: const Size(122, 32),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      )
                    : ElevatedButton.styleFrom(
                        minimumSize: const Size(122, 32),
                        backgroundColor: const Color.fromARGB(255, 33, 33, 33),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                child: Text("6-12yrs old",
                    style: count == 3
                        ? GoogleFonts.poppins(
                            color: Colors.black,
                          )
                        : GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 164, 164, 164),
                          )),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    count = 4;
                  });
                  // widget.onstepchange(count);
                },
                style: count == 4
                    ? ElevatedButton.styleFrom(
                        minimumSize: const Size(122, 32),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      )
                    : ElevatedButton.styleFrom(
                        minimumSize: const Size(122, 32),
                        backgroundColor: const Color.fromARGB(255, 33, 33, 33),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                child: Text(
                  "Young at heart",
                  style: count == 4
                      ? GoogleFonts.poppins(
                          color: Colors.black,
                        )
                      : GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 164, 164, 164),
                        ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              if (count != 0) {
                return widget.onstepchange(count);
              }
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(320, 48),
                backgroundColor: const Color.fromARGB(255, 41, 41, 41),
                elevation: 10),
            child: Text(
              "Next",
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 75, 75, 75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateStory extends StatefulWidget {
  const CreateStory({super.key});

  @override
  State<StatefulWidget> createState() {
    return CreateStoryState();
  }
}

class CreateStoryState extends State<CreateStory> {
  var currentStep = 1;
  late int count;

  Future<bool> onPop() async {
    return false;
  }

  void changeStep(int count) {
    setState(() {
      this.count = count;
      currentStep += 1;
    });
  }

  List<String> steps = [
    'Age',
    'Story theme',
    'Character',
    'customize',
    'Generate',
  ];
  @override
  Widget build(BuildContext context) {
    Widget content = FirstStep(
      onstepchange: changeStep,
    );
    if (currentStep == 2) {
      content = const Center(
        child: Text(
          "step 2",
          style: TextStyle(color: Colors.white),
        ),
      );
      switch (count) {
        case 1:
          content =  const ZeroToThree(id: "zero",);
          break;
        case 2:
          content = const Center(
            child: Text(
              "count 2",
              style: TextStyle(color: Colors.white),
            ),
          );

          break;
        case 3:
          content = const Center(
            child: Text(
              "count 3",
              style: TextStyle(color: Colors.white),
            ),
          );
          break;
        case 4:
          content = const Center(
            child: Text(
              "count 4",
              style: TextStyle(color: Colors.white),
            ),
          );
          break;
      }
    } else if (currentStep == 3) {
      content = const Login();
    }

    return PopScope(
      canPop: false,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          // color: Colors.green,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 360,
                child: FlutterHorizontalStepper(
                    steps: steps,
                    radius: 45,
                    currentStep: currentStep,
                    titleStyle: GoogleFonts.poppins(
                      fontSize: 10,
                      color: const Color.fromARGB(255, 108, 108, 108),
                    ),
                    thickness: 3,
                    completeStepColor: Colors.green,
                    currentStepColor: const Color.fromARGB(255, 76, 76, 76),
                    inActiveStepColor: const Color.fromARGB(255, 33, 33, 33),
                    child: [
                      Image.asset(
                        "assets/stepper/0_step.png",
                        height: 35,
                        width: 35,
                      ),
                      Image.asset(
                        "assets/stepper/1_step.png",
                        height: 35,
                        width: 35,
                      ),
                      Image.asset(
                        "assets/stepper/2_step.png",
                        height: 15,
                        width: 15,
                      ),
                      Image.asset(
                        "assets/stepper/3_step.png",
                        height: 15,
                        width: 15,
                      ),
                      Image.asset(
                        "assets/stepper/4_step.png",
                        height: 15,
                        width: 15,
                      ),
                    ]),
              ),
              content
            ],
          ),
        ),
      ),
    );
  }
}
