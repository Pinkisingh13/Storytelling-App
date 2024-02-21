import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:storytelling_app/models/start.dart';
import 'package:storytelling_app/screens/login_screen.dart';

class Authentication {
  FirebaseAuth firebase = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  // Now This Class Contains 3 Functions
  // 1. signInWithGoogle
  // 2. signOut
  // 3. signInwithEmailAndPassword

  // signIn with Email And Password
  Future<void> signin(GlobalKey<FormState> formKeyLogin, String enteredEmail,
      String enteredPassword) async {
    try {
      await firebase.signInWithEmailAndPassword(
          email: enteredEmail, password: enteredPassword);
      snackbarKey.currentState!.showSnackBar(const SnackBar(
        content: Text("successfully logged in! 👍"),
      ));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          snackbarKey.currentState!.clearSnackBars();
          snackbarKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Authentication failed. '),
            ),
          );
          break;
        case 'invalid-email':
          snackbarKey.currentState!.clearSnackBars();
          snackbarKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Authentication failed. '),
            ),
          );
          break;
        case 'user-disabled':
          snackbarKey.currentState!.clearSnackBars();
          snackbarKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Authentication failed. '),
            ),
          );
          break;
        case 'user-not-found':
          snackbarKey.currentState!.clearSnackBars();
          snackbarKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Authentication failed. '),
            ),
          );
          break;
        case 'invalid-credential':
          snackbarKey.currentState!.clearSnackBars();
          snackbarKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Authentication failed. '),
            ),
          );

          break;
        case 'wrong-password':
          snackbarKey.currentState!.clearSnackBars();
          snackbarKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Authentication failed. '),
            ),
          );
          break;
      }
    }
  }

  // SignUp  user with Username, Email and Password
  Future<void> signup(GlobalKey<FormState> formKeySignup, String enteredEmail,
      String enteredPassword, String enteredFullName) async {
    try {
      final user = await firebase.createUserWithEmailAndPassword(
        email: enteredEmail,
        password: enteredPassword,
      );
      snackbarKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Welcome to  🧸 "),
        ),
      );
      // save user data
      saveUser(
        UserModel(
          email: enteredEmail,
          name: enteredFullName,
          password: enteredPassword,
          profilePic: 'null',
          isNewUser: user.additionalUserInfo!.isNewUser,
          provider: "Email",
        ),
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          snackbarKey.currentState?.showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Authentication failed. '),
            ),
          );

          break;
        case 'invalid-email':
          snackbarKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Authentication failed. '),
            ),
          );
          break;
        case 'user-disabled':
          snackbarKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Authentication failed. '),
            ),
          );
          break;
        case 'user-not-found':
          snackbarKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Authentication failed. '),
            ),
          );
          break;
        case 'invalid-credential':
          snackbarKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Authentication failed. '),
            ),
          );
          break;
        case 'wrong-password':
          snackbarKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(e.message ?? 'Authentication failed. '),
            ),
          );
          break;
      }
    }
  }

  // Signin the user with Google
  Future<void> signInWithGoogle() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();

      final user = await firebase.signInWithProvider(googleAuthProvider);
      snackbarKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("successfully logged in! 👍 "),
        ),
      );
      
      final fullName = user.user!.email!.split('@')[0];
      const passWord = 'null';

      // Saving user data
      saveUser(
        UserModel(
          email: user.user!.email.toString(),
          name: fullName,
          password: passWord,
          profilePic: user.user!.photoURL.toString(),
          isNewUser: user.additionalUserInfo!.isNewUser,
          provider: user.additionalUserInfo!.providerId.toString(),
        ),
      );
      // print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        snackbarKey.currentState?.showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 200),
            content: Text(e.message ?? 'Authentication Failed'),
          ),
        );
      }
    }
  }

  // Sign out
  Future<void> signOut() async {
    await firebase.signOut();
  }

  //Saving data to database
  saveUser(UserModel user) async {
    await db.collection("users").doc(user.email).set(user.toJson());
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await db.collection("users").where("Email", isEqualTo: email).get();

    if (snapshot.docs.isNotEmpty) {
      final userData =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
      return userData;
    } else {
      throw Exception("User not found in Firestore");
    }
  }

  Future<void> authdeleteUser(String email, String password) async {
    try {
      final user = firebase.currentUser;

      final providerData = user!.providerData.first;
      if (GoogleAuthProvider().providerId == providerData.providerId) {
        // Reauthenticate the user with googleProvider
        await user.reauthenticateWithProvider(GoogleAuthProvider());

        // Delete user data from Firestore
        await dataBasedeleteUser(email);

        // Delete user account from Firebase Authentication
        await user.delete();
      } else {
        // Reauthenticate the user with email and password
        final credential =
            EmailAuthProvider.credential(email: email, password: password);
        final result = await user.reauthenticateWithCredential(credential);

        // Delete user data from Firestore
        await dataBasedeleteUser(email);

        // Delete user account from Firebase Authentication
        result.user!.delete();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        authdeleteUser(email, password);
      } else {
        snackbarKey.currentState!.showSnackBar(
          SnackBar(
            content: Text(e.code),
          ),
        );
      }
    }
  }

  Future dataBasedeleteUser(String email) async {
    try {
      return await db
          .collection("users")
          .doc(email)
          .delete()
          .then((value) => snackbarKey.currentState!.showSnackBar(
                const SnackBar(
                  content: Text("account deleted"),
                ),
              ));
    } on FirebaseAuthException catch (e) {
      snackbarKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(e.code),
        ),
      );
    }
  }
}
