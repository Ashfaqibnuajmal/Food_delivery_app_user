import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mera_app/core/routes/app_routes.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/core/widgets/loading.dart';
import 'package:mera_app/features/auth/bloc/auth_bloc_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController conformPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _showSnack(String msg) {
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

  void showErrorSnack(String msg) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
        child: Text(
          msg,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: const Duration(seconds: 3),
    ));
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.grey, // initial label color
        fontSize: 16, // label font size
        fontWeight: FontWeight.w400,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBlocBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is ErrorAuth) {
          if (Navigator.canPop(context)) Navigator.pop(context);
          showErrorSnack("Signin failed.");
        } else if (state is AuthBlocLoading) {
          showDialog(
              context: context,
              builder: (context) => const CustomoLoadingIndicator());
        } else if (state is Authenticated) {
          _showSnack("Welcome back! You’re now signed in ✅");
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(40),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(10),
                    const Text(
                      'Add details for sign up.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const Gap(30),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      decoration: _inputDecoration("Name"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),
                    const Gap(15),
                    TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration("Email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email connot be empty";
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const Gap(15),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Phone number is required";
                        } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return "Enter a valid 10-digit phone number";
                        }
                        return null;
                      },
                      controller: phoneController,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: _inputDecoration("Mobile Number"),
                    ),
                    const Gap(15),
                    TextFormField(
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: _inputDecoration("Password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password must be at least 6 charecter";
                        }
                        return null;
                      },
                    ),
                    const Gap(15),
                    TextFormField(
                      controller: conformPassword,
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: _inputDecoration('Confirm Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm your password";
                        } else if (value != passwordController.text) {
                          return "Password do not match";
                        }
                        return null;
                      },
                    ),
                    const Gap(25),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBlocBloc>().add(RegisterEvent(
                                phone: phoneController.text,
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text));
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
                          'Sign Up',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const Gap(20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                        )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Or Log In With',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Center(
                      child: OutlinedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  const CustomoLoadingIndicator());
                          context.read<AuthBlocBloc>().add(GoogleSignInEvent());
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10), // Adjusted padding
                        ),
                        child: Image.asset(
                          "assets/Google.jpeg",
                          height: 24,
                        ),
                      ),
                    ),
                    const Gap(20),
                    Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(AppRoutes.login);
                              },
                              child: const Text(
                                "Login",
                                style:
                                    TextStyle(color: AppColors.primaryOrange),
                              ),
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
