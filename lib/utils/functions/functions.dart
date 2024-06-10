import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import '../../screens/common/auth/signup/signup_screen.dart';
import '../../screens/common/welcome/welcome.dart';

class Functions {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  //image selecting fucntion for image to story
  static Future<void> selectImage(
      BuildContext context, Function galleryImage, Function cameraImage) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  galleryImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take from Camera'),
                onTap: () {
                  Navigator.pop(context);
                  cameraImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

// dialoge snack bar
  static void showSnackBar(context, String text1, String text2, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          height: MediaQuery.of(context).size.height * 0.08,
          child: Row(
            children: [
              Icon(Icons.error),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    text2,
                    style: TextStyle(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        )));
  }

  //page animation transition

  // Custom Route with Fade Transition
  static Route createFadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
          child: child,
        );
      },
    );
  }

  ///Delete Account
  static Future<void> deleteAccount(BuildContext context) async {
    final formkey = GlobalKey<FormState>();
    String errorMessage = "";
    final TextEditingController passwordController = TextEditingController();
    String? passwordError;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                    'Are you sure you want to delete your account? This action cannot be undone.'),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (errorMessage.isNotEmpty) {
                      return 'wrong Password'; // Return the error message directly
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    errorText: passwordError,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      try {
// Validate the password
                        String password = passwordController.text.trim();
// Close the password dialog and proceed with deletion

                        Functions.performDeleteAccount(context, password);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'wrong-password') {
                          errorMessage = 'Incorrect Password ';
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMessage),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: const Text('Confirm Delete'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> performDeleteAccount(
      BuildContext context, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    User? user = auth.currentUser;

    if (user != null) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );

        await user.reauthenticateWithCredential(credential);

// Delete user document from 'users' collection
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();

        await user.delete();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpScreen(),
          ),
        );
      } catch (e) {
// Handle errors during reauthentication or deletion
        print('Error during deletion: $e');
// Display error message to the user
      }
    } else {
// Prompt user to log in if not already
      print('User not logged in');
    }
  }

  ///signout function
  static signOut(BuildContext context) async {
    await auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
  }
}
