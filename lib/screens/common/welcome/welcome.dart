import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

import '../../../provider/screenType_provider.dart';
import '../../../utils/constants/button_constant.dart';
import '../../../utils/constants/color_constant.dart';
import '../../../utils/functions/functions.dart';
import '../auth/signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final role = Provider.of<ScreenTypeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Lottie.asset('assets/animations/welcome.json'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              children: [
                Text(
                  'CONTINUE AS',
                  style: TextStyle(fontSize: 14),
                ),
                CustomActionButton(
                    backColor: ColorConstant.secondary,
                    text: 'User',
                    textStyle: TextStyle(fontSize: 16, color: Colors.white),
                    onPressed: () {
                      // role.setFeatureType('teacher');
                      Navigator.push(
                          context, Functions.createFadeRoute(SignUpScreen()));
                      print(role.featureType);
                    },
                    height: 0.06),
                CustomActionButton(
                    backColor: ColorConstant.primary,
                    text: 'Coach',
                    textStyle: TextStyle(fontSize: 16, color: Colors.white),
                    onPressed: () {
                      // role.setFeatureType('student');

                      Navigator.push(
                          context, Functions.createFadeRoute(SignUpScreen()));
                      print(role.featureType);
                    },
                    height: 0.06),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
