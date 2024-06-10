import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subzero/screens/user/user_homeScreen/user_homeScreen.dart';
import '../../../../utils/constants/button_constant.dart';
import '../../../../utils/constants/color_constant.dart';
import '../../../../utils/functions/functions.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeader(),
                SizedBox(height: 20),
                _buildLoginForm(context),
                if (_isLoading)
                  CircularProgressIndicator(
                    color: Colors.red, // Adjust the color as needed
                  ),
                SizedBox(height: 20),
                _buildSignUpOption(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          "SubZero",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        AutoSizeText(
          minFontSize: 10,
          maxFontSize: 18,
          maxLines: 1,
          "Professional Services in E-Sport and Gaming World",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) return "Email cannot be empty";
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return "Please enter a valid email";
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          CustomPasswordField(
            controller: _passwordController,
            hintText: 'Password',
            isObscure: _isObscure,
            onToggle: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            validator: (value) {
              if (value!.isEmpty) return "Password cannot be empty";
              if (value.length < 6)
                return "Please enter a valid password (min. 6 characters)";
              return null;
            },
          ),
          SizedBox(height: 20),
          CustomActionButton(
            text: 'Sign In',
            onPressed: () {
              _signIn(
                _emailController.text,
                _passwordController.text,
              );
            },
            height: 0.06,
            backColor: ColorConstant.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account? '),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: ColorConstant.primary,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.pushReplacement(
            context, Functions.createFadeRoute(UserHomeScreen()));
      } on FirebaseAuthException catch (e) {
        String errorMessage = '';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided.';
        } else {
          errorMessage = e.message!;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?) validator;

  CustomTextField({
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: validator,
    );
  }
}

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  final VoidCallback onToggle;
  final String? Function(String?) validator;

  CustomPasswordField({
    required this.controller,
    required this.hintText,
    required this.isObscure,
    required this.onToggle,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
          onPressed: onToggle,
        ),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: validator,
    );
  }
}
