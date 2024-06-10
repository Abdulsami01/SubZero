import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subzero/screens/user/user_homeScreen/user_homeScreen.dart';
import '../../../../utils/constants/button_constant.dart';
import '../../../../utils/constants/color_constant.dart';
import '../../../../utils/functions/functions.dart';
import '../../welcome/welcome.dart';
import '../login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;
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
                _buildSignForm(context),
                if (_isLoading)
                  CircularProgressIndicator(
                    color: Colors.red, // Adjust the color as needed
                  ),
                SizedBox(height: 20),
                _buildLoginOption(context),
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

  Widget _buildSignForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _nameController,
            hintText: 'Name',
            validator: (value) {
              if (value!.isEmpty) return "Name cannot be empty";
              return null;
            },
          ),
          SizedBox(height: 20),
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
          CustomTextField(
            controller: _numberController,
            hintText: 'Phone Number',
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) return "Phone number cannot be empty";
              if (!RegExp(r"^\d+$").hasMatch(value)) {
                return "Please enter a valid phone number";
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
          CustomPasswordField(
            controller: _confirmPassController,
            hintText: 'Confirm Password',
            isObscure: _isObscure2,
            onToggle: () {
              setState(() {
                _isObscure2 = !_isObscure2;
              });
            },
            validator: (value) {
              if (_confirmPassController.text != _passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          CustomActionButton(
            text: 'Sign Up',
            textStyle: TextStyle(color: Colors.white),
            onPressed: () {
              _signUp(
                _emailController.text,
                _passwordController.text,
                _nameController.text,
                _numberController.text,
              );
            },
            height: 0.06,
            backColor: ColorConstant.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account? '),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Text(
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConstant.primary,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _signUp(
      String email, String password, String name, String number) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        String userId = userCredential.user!.uid;

        await _userCollection.doc(userId).set({
          'name': name,
          'email': email,
          'phoneNumber': number,
          'accountCreated': FieldValue.serverTimestamp(),
          'userId': userId,
        });

        Navigator.pushReplacement(
            context, Functions.createFadeRoute(UserHomeScreen()));
      } on FirebaseAuthException catch (e) {
        String errorMessage = '';
        if (e.code == 'weak-password') {
          errorMessage = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'The account already exists for that email.';
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
