import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storytelling_app/data/data.dart';
import 'package:storytelling_app/provider/riverpod.dart';
import 'package:storytelling_app/screens/login_screen.dart';
import 'package:storytelling_app/widget/storybodywidget.dart';
import 'package:transparent_image/transparent_image.dart';



class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  var ispop = false;
  void closeScreen() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (mounted) {
        if (user != null) {
          showDialog(
            useSafeArea: true,
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                backgroundColor: Colors.white,
                elevation: 10,
                clipBehavior: Clip.hardEdge,
                alignment: Alignment.center,
                content: Text(
                  "Do You want to exit the app?",
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
                title: const Text("Exit"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Close",
                      style: GoogleFonts.roboto(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (Platform.isIOS) {
                        exit(0);
                      } else {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      }
                    },
                    child: Text(
                      "Exit",
                      style: GoogleFonts.roboto(
                        color: const Color.fromARGB(255, 255, 0, 0),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      }
    });
  }

// Firebase cloud messaging
  // void setupPushNotification() async {
  //   final notification = FirebaseMessaging.instance;
  //   await notification.requestPermission(
  //       badge: true, announcement: true, alert: true);

  //   await notification.getToken();
  //   // print(addressToken);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   setupPushNotification();
  // }

  @override
  Widget build(
    BuildContext context,
  ) {
    final auth = ref.watch(authenticationProvider);
    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        closeScreen();
      },
      canPop: ispop,
      child: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Welcome",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              // showCloseIcon: true,
                              elevation: 20,
                              padding: const EdgeInsets.all(20),
                              duration: const Duration(milliseconds: 2000),
                              content: Text(
                                "See You Soon! 😢",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          );
                          auth.signOut();
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: const Login(),
                              type: PageTransitionType.size,
                              alignment: Alignment.topCenter,
                              duration: const Duration(milliseconds: 800),
                              reverseDuration:
                                  const Duration(milliseconds: 800),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.exit_to_app,
                          color: Color.fromARGB(255, 83, 83, 83),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Let’s create stories together",
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 148,
                width: 320,
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.white,
                  mouseCursor: MaterialStateMouseCursor.clickable,
                  child: Stack(
                    children: [
                      FadeInImage(
                        fadeInDuration: const Duration(milliseconds: 300),
                        placeholder: MemoryImage(kTransparentImage),
                        image: const AssetImage("assets/images/mainimage.png"),
                        fit: BoxFit.cover,
                        height: 148,
                        width: 320,
                      ),
                      Positioned(
                        top: 60,
                        left: 60,
                        child: SizedBox(
                          height: 51,
                          width: 182,
                          child: Column(
                            children: [
                              Text(
                                "Generate a Story",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Click here or on the plus button below to generate your own story",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 9,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Dive into our library",
                style: GoogleFonts.poppins(
                    color: const Color.fromRGBO(217, 217, 217, 0.8),
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: double.infinity,
                      color: Colors.black,
                      child: TabBar(
                        padding: const EdgeInsets.only(bottom: 10),
                        labelColor: const Color.fromARGB(255, 19, 19, 19),
                        unselectedLabelColor:
                            const Color.fromARGB(255, 86, 86, 86),
                        dividerColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelPadding: const EdgeInsets.all(3),
                        isScrollable: true,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tabAlignment: TabAlignment.center,
                        tabs: [
                          Container(
                            height: 26,
                            width: 79,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: const Color.fromARGB(255, 33, 33, 33),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "0-3yrs old",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 26,
                            width: 79,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: const Color.fromARGB(255, 33, 33, 33),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "3-6yrs old",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: const Color.fromARGB(255, 33, 33, 33),
                            ),
                            alignment: Alignment.center,
                            height: 26,
                            width: 79,
                            child: const Text(
                              "6-12yrs old",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: const Color.fromARGB(255, 33, 33, 33),
                            ),
                            alignment: Alignment.center,
                            height: 26,
                            width: 79,
                            child: const Text(
                              "Young at heart",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      // color: Colors.green,
                      height: MediaQuery.of(context).size.height - 450,
                      child: TabBarView(
                        dragStartBehavior: DragStartBehavior.start,
                        clipBehavior: Clip.hardEdge,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          for (final years in yearsData)
                            StoryBody(years: years),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
