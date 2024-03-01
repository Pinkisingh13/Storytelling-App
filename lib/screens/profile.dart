import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storytelling_app/models/start.dart';
import 'package:storytelling_app/provider/riverpod.dart';
import 'package:storytelling_app/screens/login_screen.dart';

// final currentUser = FirebaseAuth.instance.currentUser!;

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() {
    return ProfileState();
  }
}

class ProfileState extends ConsumerState<Profile> {
  late final auth = ref.read(authenticationProvider);
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authenticationProvider);
    return SingleChildScrollView(
      child: PopScope(
        canPop: false,
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          margin: const EdgeInsets.only(top: 40, left: 20),
          // color: Colors.red,
          child: FutureBuilder(
            future: auth.getUserDetails(firebase.currentUser!.email.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: Text("No data available"),
                );
              } else {
                final userData = snapshot.data as UserModel;
                Widget image = Center(
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(userData.profilePic),
                      ),
                      color: Colors.green,
                    ),
                  ),
                );

                if (userData.profilePic == 'null') {
                  image = Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 40, bottom: 20),
                      height: 90,
                      width: 90,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    image,
                    const SizedBox(
                      height: 33,
                    ),
                    // user email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: GoogleFonts.lato(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          userData.email,
                          style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 234, 207, 216)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 43, 43, 43),
                      endIndent: 30,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "username",
                          style: GoogleFonts.lato(color: Colors.grey),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      userData.name,
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 234, 207, 216),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 43, 43, 43),
                      endIndent: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "bio",
                              style: GoogleFonts.lato(color: Colors.grey),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "empty bio",
                          style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 234, 207, 216)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: Color.fromARGB(255, 43, 43, 43),
                          endIndent: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Dangerous area",
                      style:
                          GoogleFonts.lato(color: Colors.white, fontSize: 17),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton.icon(
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: Color.fromARGB(255, 57, 57, 57),
                      ),
                      onPressed: () async {
                        showDialog(
                          useSafeArea: true,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              surfaceTintColor:
                                  const Color.fromARGB(255, 218, 25, 25),
                              shadowColor: Colors.white,
                              elevation: 10,
                              clipBehavior: Clip.hardEdge,
                              alignment: Alignment.center,
                              content: Text(
                                "you will lose your account data",
                                style: GoogleFonts.roboto(),
                              ),
                              title: const Text("Are you sure?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Close"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await auth.authdeleteUser(
                                        userData.email, userData.password);
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(
                                        // ignore: use_build_context_synchronously
                                        context,
                                        PageTransition(
                                            child: const Login(),
                                            type: PageTransitionType.scale,
                                            alignment: Alignment.bottomRight),
                                            );
                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      label: Text(
                        "Delete account",
                        style: GoogleFonts.poppins(color: Colors.grey),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
