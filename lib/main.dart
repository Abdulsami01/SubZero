import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subzero/provider/coaching_provider.dart';
import 'package:subzero/provider/legal_provider.dart';
import 'package:subzero/provider/package_provider.dart';
import 'package:subzero/provider/screenType_provider.dart';
import 'package:subzero/provider/sponsorship_provider.dart';
import 'package:subzero/screens/common/auth/signup/signup_screen.dart';
import 'package:subzero/screens/user/coaching/coaching_payment.dart';
import 'package:subzero/screens/user/user_homeScreen/user_homeScreen.dart';
import 'package:subzero/utils/constants/color_constant.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScreenTypeProvider()),
        ChangeNotifierProvider(create: (context) => CoachingState()),
        ChangeNotifierProvider(create: (context) => PackageState()),
        ChangeNotifierProvider(create: (context) => LegalState()),
        ChangeNotifierProvider(create: (context) => SponsorshipState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          buttonTheme: ButtonThemeData(
            buttonColor: ColorConstant.primary,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: ColorConstant.primary,
            primary: ColorConstant.primary,
            secondary: ColorConstant.secondary,
          ),
          useMaterial3: true,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return AlertDialog(
                title: const Text('There is an issue'),
                content: const Text(
                    'Please check your internet or restart the app.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              );
            } else if (snapshot.hasData) {
              return UserHomeScreen();
            } else {
              return SignUpScreen();
              // return WelcomeScreen();
            }
          },
        ),
      ),
    );
  }
}
