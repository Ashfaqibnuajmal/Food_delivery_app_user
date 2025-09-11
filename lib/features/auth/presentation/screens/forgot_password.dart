import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mera_app/core/theme/text_style.dart';
import 'package:mera_app/core/widgets/show_snack.dart';
import 'package:mera_app/features/auth/presentation/widgets/button.dart';
import 'package:mera_app/features/auth/presentation/widgets/email.dart';
import 'package:mera_app/features/auth/services/auth_service.dart';

class ForgotPassword extends StatelessWidget {
  final AuthService authService = AuthService();
  final _formState = GlobalKey<FormState>();
  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
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
                style: blackBoldBigTextStyle,
              ),
              const Gap(10),
              const Text(
                  'Enter your email for the verification  process. We will send 4 digit  code to your email',
                  style: lightBlackTextStyle),
              const Gap(80),
              EmailField(
                controller: emailController,
              ),
              const Gap(35),
              Center(
                child: PrimaryButton(
                  text: "Send code",
                  onPressed: () {
                    if (_formState.currentState!.validate()) {
                      try {
                        authService.passWordReset(emailController.text.trim());
                        ShowSnackBar.show(
                            context, "Verification link sent to your email.");
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.message.toString()),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ]),
          ),
        )));
  }
}
