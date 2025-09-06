import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_app/core/routes/app_routes.dart';
import 'package:mera_app/features/auth/bloc/auth_bloc_bloc.dart';
import 'package:mera_app/features/auth/presentation/screens/login.dart';
import 'package:mera_app/features/auth/presentation/screens/reset_password.dart';
import 'package:mera_app/features/auth/presentation/screens/sign_up.dart';
import 'package:mera_app/features/home/screens/home_screen.dart';
import 'package:mera_app/features/onboarding/screens/intro_screen.dart';
import 'package:mera_app/features/onboarding/screens/splash_screen.dart';
import 'package:mera_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => AuthBlocBloc())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: AppRoutes.splash,
          routes: {
            AppRoutes.splash: (context) => SplashScreen(),
            AppRoutes.onboarding: (context) => OnboardingScreens(),
            AppRoutes.login: (context) => Login(),
            AppRoutes.signUp: (context) => SignUp(),
            AppRoutes.home: (context) => HomeScreen(),
            AppRoutes.resetPassword: (context) => ResetPassword(),
          },
        ));
  }
}
