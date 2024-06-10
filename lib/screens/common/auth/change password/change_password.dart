import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../forgot/forgot.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  String errorMessage = "";
  bool isLoading = false;
  bool _isObscure3 = true;
  bool _isObscure2 = true;
  bool _isObscure1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _oldPasswordController,
                obscureText: _isObscure1,
                decoration: InputDecoration(
                  labelText: 'Old Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure1 ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure1 = !_isObscure1;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Old Password is required';
                  }
                  if (errorMessage.isNotEmpty) {
                    return 'Incorrect Password'; // Return the error message directly
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Forgotpass()),
                      );
                    },
                    child: Text(
                      "Forget Old Password ?",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _newPasswordController,
                obscureText: _isObscure2,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure2 ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure2 = !_isObscure2;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'New Password is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmNewPasswordController,
                obscureText: _isObscure3,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure3 ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure3 = !_isObscure3;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm New Password is required';
                  }
                  if (value != _newPasswordController.text) {
                    return 'New Password and Confirm New Password do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });

                        await changePassword();

                        setState(() {
                          isLoading = false;
                        });
                      },
                child: isLoading
                    ? CircularProgressIndicator()
                    : const Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> changePassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Get the current user
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        try {
          // Clear previous error message
          setState(() {
            errorMessage = "";
          });

          // Reauthenticate with the old password
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: _oldPasswordController.text,
          );
          await user.reauthenticateWithCredential(credential);

          // Update the password
          await user.updatePassword(_newPasswordController.text);

          // Clear controllers
          setState(() {
            _oldPasswordController.clear();
            _newPasswordController.clear();
            _confirmNewPasswordController.clear();
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password changed successfully')),
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            setState(() {
              errorMessage = "Old password is incorrect";
            });
          } else {
            // Handle other errors
            setState(() {
              errorMessage = "Failed to change password: ${e.message}";
            });
          }
        }
      } else {
        setState(() {
          errorMessage = "No user is signed in";
        });
      }
    }
    // Clear controllers
    setState(() {
      _oldPasswordController.clear();
      _newPasswordController.clear();
      _confirmNewPasswordController.clear();
    });
  }
}
