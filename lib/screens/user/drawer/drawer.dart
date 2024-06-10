import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subzero/screens/user/coaching/choaching_services.dart';

import '../../../utils/constants/color_constant.dart';
import '../../../utils/functions/functions.dart';
import '../../common/auth/change password/change_password.dart';

const Gradient kGradient = LinearGradient(colors: [Colors.green, Colors.blue]);

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  final user = FirebaseAuth.instance.currentUser!;

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(80),
        ),
      ),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SubZero',
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  user.email!,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.video_library_outlined),
            title: Text('Coaching'),
            onTap: () {
              Navigator.push(
                  context, Functions.createFadeRoute(CoachingServices()));
            },
          ),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text('Legal & Registration'),
            onTap: () {
              Navigator.push(
                  context, Functions.createFadeRoute(CoachingServices()));
            },
          ),
          ListTile(
            leading: Icon(Icons.chrome_reader_mode),
            title: Text('Sponsorship'),
            onTap: () {
              Navigator.push(
                  context, Functions.createFadeRoute(CoachingServices()));
            },
          ),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePassword(),
                  ),
                );
              },
              child: Text('Change Password'),
              color: ColorConstant.primary,
              minWidth: 10,
              textColor: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: MaterialButton(
              onPressed: () {
                Functions.deleteAccount(context);
              },
              child: Text('Delete Account'),
              color: Colors.white,
              minWidth: 10,
              textColor: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: MaterialButton(
              onPressed: () {
                Functions.signOut(context);
              },
              child: Text('Log out'),
              color: Colors.redAccent,
              minWidth: 10,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
    );
  }
}
