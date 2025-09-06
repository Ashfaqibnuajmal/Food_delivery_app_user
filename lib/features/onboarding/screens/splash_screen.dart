import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mera_app/core/routes/app_routes.dart';
import 'package:mera_app/features/auth/bloc/auth_bloc_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<AuthBlocBloc>().add(AuthCheckEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthBlocBloc, AuthBlocState>(
          listener: (context, state) {
            if (state is WelcomeState) {
              Navigator.of(context).pushReplacementNamed(AppRoutes.onboarding);
            } else if (state is Unauthenticated) {
              Navigator.of(context).pushReplacementNamed(AppRoutes.login);
            } else if (state is Authenticated) {
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            } else if (state is ErrorAuth) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error:${state.error}")));
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/Logo.jpeg", height: 250),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  LottieBuilder.asset("assets/splash_screen_loading.json"),
                ],
              ),
            );
          },
        ));
  }
}
