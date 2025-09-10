import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/features/auth/services/auth_service.dart';

class ForgotPassword extends StatelessWidget {
  final AuthService authService = AuthService();
  final _formState = GlobalKey<FormState>();
  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    void showSnack(String msg) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              msg,
              style: const TextStyle(
                  color: AppColors.primaryOrange,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }

    TextEditingController emailController = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.canPop(context);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: SingleChildScrollView(
            child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Gap(40),
              const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Gap(10),
              const Text(
                'Enter your email for the verification  process. We will send 4 digit  code to your email',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const Gap(80),
              Form(
                key: _formState,
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email cannot be empty";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const Gap(35),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formState.currentState!.validate()) {
                      try {
                        authService.passWordReset(emailController.text.trim());
                        showSnack("Varification link send to your email.");
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.message.toString()),
                            backgroundColor: Colors.red,
                            behavior:
                                SnackBarBehavior.floating, // looks cleaner
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 80),
                  ),
                  child: const Text(
                    'Send code',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ]),
          ),
        )));
  }
}
