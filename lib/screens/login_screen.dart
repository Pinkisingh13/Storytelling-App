import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storytelling_app/provider/riverpod.dart';
import 'package:storytelling_app/screens/bottombar.dart';

final firebase = FirebaseAuth.instance;

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login>
    with SingleTickerProviderStateMixin {
  final formKeyLogin = GlobalKey<FormState>();
  final formKeySignup = GlobalKey<FormState>();

  var enteredEmail = '';
  var enteredPassword = '';
  final usernameController = TextEditingController();

  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  // Sign in
  void signin() async {
    final isValid = formKeyLogin.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKeyLogin.currentState!.save();
    final auth = ref.watch(authenticationProvider);
    await auth.signin(formKeyLogin, enteredEmail, enteredPassword);

    if (FirebaseAuth.instance.currentUser != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        PageTransition(
          child: const BottomNavBar(),
          type: PageTransitionType.size,
          alignment: Alignment.bottomCenter,
          duration: const Duration(milliseconds: 800),
          reverseDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

// Create User
  void createuser() async {
    final isValid = formKeySignup.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKeySignup.currentState!.save();

    var enteredFullName = usernameController.text;
    final auth = ref.watch(authenticationProvider);
    await auth.signup(
        formKeySignup, enteredEmail, enteredPassword, enteredFullName);
    if (FirebaseAuth.instance.currentUser != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        PageTransition(
          child: const BottomNavBar(),
          type: PageTransitionType.size,
          alignment: Alignment.bottomCenter,
          duration: const Duration(milliseconds: 800),
          reverseDuration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  // Login with Google
  void loginWithGoogle() async {
    final auth = ref.watch(authenticationProvider);
    try {
      await auth.signInWithGoogle();
      if (FirebaseAuth.instance.currentUser != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          PageTransition(
            child: const BottomNavBar(),
            type: PageTransitionType.size,
            alignment: Alignment.bottomCenter,
            duration: const Duration(milliseconds: 800),
            reverseDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    } catch (e) {
      print("Error signin in the with google: $e");
    }
  }

  var isobscure = false;

  IconButton button() {
    return IconButton(
      onPressed: () {
        setState(() {
          isobscure = !isobscure;
        });
      },
      icon: const Icon(
        Icons.remove_red_eye_rounded,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        // print(width);

        return SafeArea(
          child: PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: width < 600
                  ? SingleChildScrollView(
                      child: Center(
                        child: Container(
                          height: 870,
                          // color: Colors.red,
                          margin: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                width: 267,
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/logo.png'),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "Create an account",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Sign up and get started on your storytelling adventure with AIYO!",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                // color: Colors.orange,
                                padding:
                                    const EdgeInsets.only(right: 10, left: 10),
                                height: 600,

                                child: Column(
                                  children: [
                                    TabBar(
                                      labelStyle: GoogleFonts.poppins(),
                                      dividerColor:
                                          const Color.fromARGB(255, 20, 20, 20),
                                      dividerHeight: 2,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicatorColor:
                                          const Color.fromARGB(255, 50, 50, 50),
                                      labelColor: Colors.white,
                                      controller: tabController,
                                      unselectedLabelColor:
                                          const Color.fromARGB(
                                              255, 137, 137, 137),
                                      tabs: const [
                                        Tab(
                                          child: Text("Login"),
                                        ),
                                        Tab(
                                          child: Text("Sign up"),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        controller: tabController,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            // Login
                                            child: Form(
                                              key: formKeyLogin,
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 20,
                                                  ),

                                                  //Email (Login)
                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value
                                                              .trim()
                                                              .isEmpty ||
                                                          !value
                                                              .contains('@')) {
                                                        return "Please enter a valid email address";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (newValue) {
                                                      enteredEmail = newValue!;
                                                    },
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 136, 136, 136),
                                                    ),
                                                    cursorColor:
                                                        const Color.fromARGB(
                                                            255, 95, 95, 95),
                                                    cursorOpacityAnimates: true,
                                                    autocorrect: false,
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: InputDecoration(
                                                      border:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    78,
                                                                    78,
                                                                    78)),
                                                      ),
                                                      focusedBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255, 79, 79, 79),
                                                        ),
                                                      ),
                                                      isDense: true,
                                                      floatingLabelAlignment:
                                                          FloatingLabelAlignment
                                                              .start,
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .auto,
                                                      label: Text(
                                                        "Email",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          color: const Color
                                                              .fromARGB(255,
                                                              180, 180, 180),
                                                        ),
                                                      ),
                                                    ),
                                                    textCapitalization:
                                                        TextCapitalization.none,
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),

                                                  //Password (Login)
                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.trim().length <
                                                              6) {
                                                        return "Password must be at least 6 characters long";
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (newValue) {
                                                      enteredPassword =
                                                          newValue!;
                                                    },
                                                    style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 136, 136, 136),
                                                    ),
                                                    cursorColor:
                                                        const Color.fromARGB(
                                                            255, 95, 95, 95),
                                                    cursorOpacityAnimates: true,
                                                    obscureText: isobscure,
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: InputDecoration(
                                                      border:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255, 79, 79, 79),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255, 79, 79, 79),
                                                        ),
                                                      ),
                                                      isDense: true,
                                                      floatingLabelAlignment:
                                                          FloatingLabelAlignment
                                                              .start,
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .auto,
                                                      label: Text(
                                                        "Password",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          color: const Color
                                                              .fromARGB(255,
                                                              180, 180, 180),
                                                        ),
                                                      ),
                                                      // suffix: button(),
                                                      suffixIcon: button(),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 60,
                                                  ),

                                                  ReusableWidget(
                                                    loginWithGoogle:
                                                        loginWithGoogle,
                                                    createuser: createuser,
                                                    text: 'Login',
                                                    signin: signin,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // Sign up
                                          Form(
                                            key: formKeySignup,
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 15,
                                                ),

                                                // Username

                                                TextFormField(
                                                  controller:
                                                      usernameController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return "Please enter you fullname";
                                                    }
                                                    return null;
                                                  },
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 136, 136, 136),
                                                  ),
                                                  cursorColor:
                                                      const Color.fromARGB(
                                                          255, 95, 95, 95),
                                                  cursorOpacityAnimates: true,
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: InputDecoration(
                                                    border:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 79, 79, 79),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 79, 79, 79),
                                                      ),
                                                    ),
                                                    isDense: true,
                                                    floatingLabelAlignment:
                                                        FloatingLabelAlignment
                                                            .start,
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .auto,
                                                    label: Text(
                                                      "Username",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 180, 180, 180),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                // Email
                                                TextFormField(
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty ||
                                                        !value.contains('@')) {
                                                      return "Please enter a valid email address";
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (newValue) {
                                                    enteredEmail = newValue!;
                                                  },
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 136, 136, 136),
                                                  ),
                                                  cursorColor:
                                                      const Color.fromARGB(
                                                          255, 95, 95, 95),
                                                  cursorOpacityAnimates: true,
                                                  autocorrect: false,
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: InputDecoration(
                                                    border:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 79, 79, 79),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 79, 79, 79),
                                                      ),
                                                    ),
                                                    isDense: true,
                                                    floatingLabelAlignment:
                                                        FloatingLabelAlignment
                                                            .start,
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .auto,
                                                    label: Text(
                                                      "Email",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 180, 180, 180),
                                                      ),
                                                    ),
                                                  ),
                                                  textCapitalization:
                                                      TextCapitalization.none,
                                                ),

                                                // Password
                                                TextFormField(
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().length <
                                                            6) {
                                                      return "Password must be 6 characters long";
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (newValue) {
                                                    enteredPassword = newValue!;
                                                  },
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 136, 136, 136),
                                                  ),
                                                  cursorColor:
                                                      const Color.fromARGB(
                                                          255, 95, 95, 95),
                                                  cursorOpacityAnimates: true,
                                                  obscureText: isobscure,
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: InputDecoration(
                                                    border:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 79, 79, 79),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 79, 79, 79),
                                                      ),
                                                    ),
                                                    suffixIcon: button(),
                                                    isDense: true,
                                                    label: Text(
                                                      "Password",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 180, 180, 180),
                                                      ),
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 40,
                                                ),

                                                ReusableWidget(
                                                    loginWithGoogle:
                                                        loginWithGoogle,
                                                    createuser: createuser,
                                                    text: 'Sign up',
                                                    signin: signin),
                                                // consent message
                                                const SizedBox(
                                                  height: 40,
                                                ),
                                                Container(
                                                  height: 39,
                                                  width: 267,
                                                  margin: const EdgeInsets.only(
                                                      top: 10),
                                                  child: const Text.rich(
                                                    TextSpan(
                                                      text:
                                                          "By continuing, I’m agreeing to the ",
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 200, 199, 199),
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              "Terms of Service ",
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            color: Colors.white,
                                                            decorationColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: " and ",
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    200,
                                                                    199,
                                                                    199),
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "Privacy Policy.",
                                                          style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            color: Colors.white,
                                                            decorationColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
                    )
                  // Widgth > 600

                  : SingleChildScrollView(
                      child: Center(
                        child: Container(
                          decoration: width >= 1000
                              ? const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color.fromARGB(255, 49, 49, 49),
                                    Colors.black,
                                  ]),
                                )
                              : const BoxDecoration(),
                          margin: const EdgeInsets.symmetric(
                              vertical: 50, horizontal: 40),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 30, left: 20),
                                  child: Column(
                                    children: [
                                      Image.asset('assets/images/logo.png'),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        "Create an account",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Sign up and get started on your storytelling adventure with AIYO!",
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: Container(
                                  padding: width < 1000
                                      ? const EdgeInsets.only(
                                          right: 20, left: 10)
                                      : const EdgeInsets.only(
                                          right: 70, left: 50),
                                  margin: width < 1000
                                      ? const EdgeInsets.only(right: 20)
                                      : const EdgeInsets.only(
                                          right: 70,
                                          top: 40,
                                        ),
                                  height: width < 1000 ? 600 : 670,
                                  child: Column(
                                    children: [
                                      TabBar(
                                        padding: width > 1000
                                            ? const EdgeInsets.all(10)
                                            : const EdgeInsets.all(0),
                                        labelStyle: GoogleFonts.poppins(),
                                        dividerColor: const Color.fromARGB(
                                            255, 20, 20, 20),
                                        dividerHeight: 2,
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        indicatorColor: const Color.fromARGB(
                                            255, 50, 50, 50),
                                        labelColor: Colors.white,
                                        controller: tabController,
                                        unselectedLabelColor:
                                            const Color.fromARGB(
                                                255, 137, 137, 137),
                                        tabs: const [
                                          Tab(
                                            child: Text("Login"),
                                          ),
                                          Tab(
                                            child: Text("Sign up"),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                          controller: tabController,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              // Login
                                              child: Form(
                                                key: formKeyLogin,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),

                                                    //Email (Login)
                                                    SizedBox(
                                                      width: 400,
                                                      child: TextFormField(
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value
                                                                  .trim()
                                                                  .isEmpty ||
                                                              !value.contains(
                                                                  '@')) {
                                                            return "Please enter a valid email address";
                                                          }
                                                          return null;
                                                        },
                                                        onSaved: (newValue) {
                                                          enteredEmail =
                                                              newValue!;
                                                        },
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              136,
                                                              136,
                                                              136),
                                                        ),
                                                        cursorColor: const Color
                                                            .fromARGB(
                                                            255, 95, 95, 95),
                                                        cursorOpacityAnimates:
                                                            true,
                                                        autocorrect: false,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              const UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      78,
                                                                      78,
                                                                      78),
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              const UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      79,
                                                                      79,
                                                                      79),
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          floatingLabelAlignment:
                                                              FloatingLabelAlignment
                                                                  .start,
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .auto,
                                                          label: Text(
                                                            "Email",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 12,
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  180,
                                                                  180,
                                                                  180),
                                                            ),
                                                          ),
                                                        ),
                                                        textCapitalization:
                                                            TextCapitalization
                                                                .none,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),

                                                    //Password (Login)
                                                    SizedBox(
                                                      width: 400,
                                                      child: TextFormField(
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value
                                                                      .trim()
                                                                      .length <
                                                                  6) {
                                                            return "Password must be at least 6 characters long";
                                                          }
                                                          return null;
                                                        },
                                                        onSaved: (newValue) {
                                                          enteredPassword =
                                                              newValue!;
                                                        },
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              136,
                                                              136,
                                                              136),
                                                        ),
                                                        cursorColor: const Color
                                                            .fromARGB(
                                                            255, 95, 95, 95),
                                                        cursorOpacityAnimates:
                                                            true,
                                                        obscureText: isobscure,
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon: button(),
                                                          border:
                                                              const UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      79,
                                                                      79,
                                                                      79),
                                                            ),
                                                          ),
                                                          focusedBorder:
                                                              const UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      79,
                                                                      79,
                                                                      79),
                                                            ),
                                                          ),
                                                          isDense: true,
                                                          floatingLabelAlignment:
                                                              FloatingLabelAlignment
                                                                  .start,
                                                          floatingLabelBehavior:
                                                              FloatingLabelBehavior
                                                                  .auto,
                                                          label: Text(
                                                            "Password",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 12,
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  180,
                                                                  180,
                                                                  180),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 80,
                                                    ),

                                                    ReusableWidget(
                                                      loginWithGoogle:
                                                          loginWithGoogle,
                                                      createuser: createuser,
                                                      text: 'Login',
                                                      signin: signin,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            // Sign up
                                            Form(
                                              key: formKeySignup,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  width > 1000
                                                      ? const SizedBox(
                                                          height: 14,
                                                        )
                                                      : const SizedBox(
                                                          height: 20,
                                                        ),

                                                  // Username

                                                  SizedBox(
                                                    width: 400,
                                                    child: TextFormField(
                                                      controller:
                                                          usernameController,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value
                                                                .trim()
                                                                .isEmpty) {
                                                          return "Please enter you fullname";
                                                        }
                                                        return null;
                                                      },
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 136, 136, 136),
                                                      ),
                                                      cursorColor:
                                                          const Color.fromARGB(
                                                              255, 95, 95, 95),
                                                      cursorOpacityAnimates:
                                                          true,
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    79,
                                                                    79,
                                                                    79),
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    79,
                                                                    79,
                                                                    79),
                                                          ),
                                                        ),
                                                        isDense: true,
                                                        label: Text(
                                                          "Username",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 12,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                180, 180, 180),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  width > 1000
                                                      ? const SizedBox(
                                                          height: 20,
                                                        )
                                                      : const SizedBox(
                                                          height: 10,
                                                        ),
                                                  // Email
                                                  SizedBox(
                                                    width: 400,
                                                    child: TextFormField(
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value
                                                                .trim()
                                                                .isEmpty ||
                                                            !value.contains(
                                                                '@')) {
                                                          return "Please enter a valid email address";
                                                        }
                                                        return null;
                                                      },
                                                      onSaved: (newValue) {
                                                        enteredEmail =
                                                            newValue!;
                                                      },
                                                      keyboardType:
                                                          TextInputType
                                                              .emailAddress,
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 136, 136, 136),
                                                      ),
                                                      cursorColor:
                                                          const Color.fromARGB(
                                                              255, 95, 95, 95),
                                                      cursorOpacityAnimates:
                                                          true,
                                                      autocorrect: false,
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    79,
                                                                    79,
                                                                    79),
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    79,
                                                                    79,
                                                                    79),
                                                          ),
                                                        ),
                                                        isDense: true,
                                                        floatingLabelAlignment:
                                                            FloatingLabelAlignment
                                                                .start,
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .auto,
                                                        label: Text(
                                                          "Email",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 12,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                180, 180, 180),
                                                          ),
                                                        ),
                                                      ),
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .none,
                                                    ),
                                                  ),

                                                  // Password

                                                  width > 1000
                                                      ? const SizedBox(
                                                          height: 20,
                                                        )
                                                      : const SizedBox(
                                                          height: 0,
                                                        ),
                                                  SizedBox(
                                                    width: 400,
                                                    child: TextFormField(
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value
                                                                    .trim()
                                                                    .length <
                                                                6) {
                                                          return "Password must be 6 characters long";
                                                        }
                                                        return null;
                                                      },
                                                      onSaved: (newValue) {
                                                        enteredPassword =
                                                            newValue!;
                                                      },
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 136, 136, 136),
                                                      ),
                                                      cursorColor:
                                                          const Color.fromARGB(
                                                              255, 95, 95, 95),
                                                      cursorOpacityAnimates:
                                                          true,
                                                      obscureText: isobscure,
                                                      decoration:
                                                          InputDecoration(
                                                        suffixIcon: button(),
                                                        border:
                                                            const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    79,
                                                                    79,
                                                                    79),
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    79,
                                                                    79,
                                                                    79),
                                                          ),
                                                        ),
                                                        isDense: true,
                                                        label: Text(
                                                          "Password",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 12,
                                                            color: const Color
                                                                .fromARGB(255,
                                                                180, 180, 180),
                                                          ),
                                                          softWrap: true,
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  width > 1000
                                                      ? const SizedBox(
                                                          height: 60,
                                                        )
                                                      : const SizedBox(
                                                          height: 40,
                                                        ),

                                                  ReusableWidget(
                                                      loginWithGoogle:
                                                          loginWithGoogle,
                                                      createuser: createuser,
                                                      text: 'Sign up',
                                                      signin: signin),
                                                  // consent message
                                                  const SizedBox(
                                                    height: 40,
                                                  ),
                                                  Container(
                                                    height: 39,
                                                    width: 267,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: const Text.rich(
                                                      TextSpan(
                                                        text:
                                                            "By continuing, I’m agreeing to the ",
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              200,
                                                              199,
                                                              199),
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                "Terms of Service ",
                                                            style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              color:
                                                                  Colors.white,
                                                              decorationColor:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: " and ",
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      200,
                                                                      199,
                                                                      199),
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "Privacy Policy.",
                                                            style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              color:
                                                                  Colors.white,
                                                              decorationColor:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
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
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

class ReusableWidget extends StatelessWidget {
  const ReusableWidget(
      {super.key,
      required this.loginWithGoogle,
      required this.createuser,
      required this.signin,
      required this.text});

  final Function() loginWithGoogle;
  final Function() createuser;
  final Function() signin;

  final String text;

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        OutlinedButton(
          onPressed: text.contains('Sign') ? createuser : signin,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            minimumSize: const Size(150, 47),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 242, 221, 103),
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // google in signup tab
            OutlinedButton.icon(
              label: Text(
                "Google",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
              ),
              onPressed: loginWithGoogle,
              icon: Image.asset(
                "assets/icons/icongoogle.png",
                height: 20,
                width: 20,
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 40),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            // ios in signup tab
            ElevatedButton.icon(
              label: Text(
                "ioS",
                style: GoogleFonts.poppins(fontSize: 15),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    // MaterialPageRoute(
                    //   builder: (context) => const BottomNavBar(),
                    // ),
                    PageTransition(
                      child: const BottomNavBar(),
                      type: PageTransitionType.size,
                      isIos: true,
                      alignment: Alignment.bottomCenter,
                      reverseDuration: const Duration(milliseconds: 800),
                      duration: const Duration(milliseconds: 800),
                    ));
              },
              icon: Image.asset(
                "assets/icons/icon_apple.png",
                height: 25,
                width: 25,
                color: Colors.black,
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(0, 40),
              ),
            ),
          ],
        ),
      ],
    );

    final width = MediaQuery.of(context).size.width;
    if (width >= 1000) {
      content = Column(
        children: [
          OutlinedButton(
            onPressed: text.contains('Sign') ? createuser : signin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size(250, 48),
            ),
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 242, 221, 103),
                fontSize: 15,
              ),
            ),
          ),

          SizedBox(
            height: text.contains("Sign") ? 30 : 70,
          ),
          // google in signup tab
          OutlinedButton.icon(
            label: Text(
              "Google",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
            ),
            onPressed: loginWithGoogle,
            icon: Image.asset(
              "assets/icons/icongoogle.png",
              height: 20,
              width: 20,
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 48),
            ),
          ),

          SizedBox(
            height: text.contains("Sign") ? 30 : 50,
          ),
          // ios in signup tab
          ElevatedButton.icon(
            label: Text(
              "ioS",
              style: GoogleFonts.poppins(fontSize: 15),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavBar(),
                ),
              );
            },
            icon: Image.asset(
              "assets/icons/icon_apple.png",
              height: 25,
              width: 25,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: const Size(200, 48),
            ),
          ),
        ],
      );
    }
    return content;
  }
}
