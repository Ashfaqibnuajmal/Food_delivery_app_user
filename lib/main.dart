import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_app/core/blocs/category/food_category_filter_cubit.dart';
import 'package:mera_app/features/cart/bloc/cart_bloc.dart';
import 'package:mera_app/features/cart/cubit/cart_quantity_cubit.dart';
import 'package:mera_app/features/cart/cubit/checkout_cubit.dart';
import 'package:mera_app/features/cart/cubit/drink_selection_cubit.dart';
import 'package:mera_app/features/favorites/bloc/favorite_bloc.dart';
import 'package:mera_app/core/blocs/search/search_bloc.dart';
import 'package:mera_app/core/blocs/search/search_event.dart';
import 'package:mera_app/core/routes/app_routes.dart';
import 'package:mera_app/features/auth/bloc/auth_bloc_bloc.dart';
import 'package:mera_app/features/auth/presentation/screens/forgot_password.dart';
import 'package:mera_app/features/auth/presentation/screens/login.dart';
import 'package:mera_app/features/auth/presentation/screens/sign_up.dart';
import 'package:mera_app/features/bottom_nav/screens/main_navigation.dart';
import 'package:mera_app/features/home/bloc/ai_chat_bloc.dart';
import 'package:mera_app/features/home/cubit/food_portion_cubit.dart';
import 'package:mera_app/features/home/cubit/today_offer_cubit.dart';
import 'package:mera_app/features/onboarding/screens/intro_screen.dart';
import 'package:mera_app/features/onboarding/screens/splash_screen.dart';
import 'package:mera_app/core/constant/firebase_options.dart';

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
        providers: [
          BlocProvider(
            create: (context) => FoodSearchBloc()..add(const SetFoodItems([])),
          ),
          BlocProvider(create: (context) => FoodCategoryFilterCubit()),
          BlocProvider(create: (context) => DrinkSelectionCubit()),
          BlocProvider(create: (context) => CheckoutCubit()),
          BlocProvider(
              create: (context) => FoodPortionCubit(initialHalf: false)),
          BlocProvider(create: (context) => CartQuantityCubit()),
          BlocProvider(create: (context) => CartBloc()),
          BlocProvider(create: (context) => FavoriteBloc()),
          BlocProvider(create: (context) => TodayOfferCubit()),
          BlocProvider(create: (context) => AuthBlocBloc()),
          BlocProvider(create: (context) => AiChatBloc())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: AppRoutes.splash,
          routes: {
            AppRoutes.splash: (context) => const SplashScreen(),
            AppRoutes.onboarding: (context) => const OnboardingScreens(),
            AppRoutes.login: (context) => Login(),
            AppRoutes.signUp: (context) => const SignUp(),
            AppRoutes.home: (context) => const BottomNavBar(),
            AppRoutes.forgotPassword: (context) => ForgotPassword(),
          },
        ));
  }
}
